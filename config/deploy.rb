require 'colored'
require File.join File.dirname(__FILE__), 'deploy_helper'
require 'bundler/capistrano'
# require 'sidekiq/capistrano'

set :stages, %w(production staging)
set :default_stage, 'staging'

set :deploy_via, :remote_cache
set :repository,  "git@github.com:jtm-ev/website.git"

set :ssl_csr, false
set :ssl_key, false

require 'capistrano/ext/multistage'

set :user,        "jtm"
set :application, "website"
set :domain,      "jtm.m1.relaunche.de"

ssh_options[:port] = 22
ssh_options[:forward_agent] = true

set :use_sudo,    false
set :normalize_asset_timestamps, false


set :scm, :git

set :git_enable_submodules, 0

role :app, domain
role :web, domain
role :db,  domain, :primary => true

set :default_environment, {
  'PATH' => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH"
}

###################################################################################
# Default Deploy Hooks
###################################################################################

namespace :deploy do
  task(:stop, :roles => :app) {
    run unicorn_stop_cmd
  }

  task(:restart, :roles => :app) {
    run unicorn_restart_cmd
  }

  task(:start, :roles => :app) {
    run unicorn_start_cmd
  }
  
  # desc "Show deployed revision on server"
  # task(:show_revision, :roles => :app) {
  #   # run "cat #{File.join(current_path,'REVISION')}"
  # }
  
  # ATTENTION!!!!
  # task :reset, :roles => :app do
  #   run "cd #{current_path} && bundle exec rake db:reset RAILS_ENV=#{rails_env}"
  # end
end

before 'bundle:install' do
  run "cd #{release_path}; mv .rbenv-version.example .rbenv-version"
end

###################################################################################
# GEMs and ASSETs
###################################################################################

set(:cd_bundle_cmd)  { "cd #{release_path}; bundle" }
set(:bundle_path) {
  # if rails_env == 'production'
  #   "#{release_path}/vendor/bundle" # in production we want a clean gemset for each release
  # else
    "#{shared_path}/bundle"
  # end
}

namespace :bundle do
  task :install do
    run "#{cd_bundle_cmd} install --gemfile #{release_path}/Gemfile --path #{bundle_path} --without development test --binstubs --shebang ruby-local-exec"
    # run "#{cd_bundle_cmd} install --gemfile #{release_path}/Gemfile --path #{bundle_path} --deployment --without development test --binstubs --shebang ruby-local-exec"
  end
end

namespace :deploy do
  namespace :assets do
    task :precompile do
      run "#{cd_bundle_cmd} exec rake RAILS_ENV=#{rails_env} RAILS_GROUPS=assets assets:precompile"
    end
  end
end

# after 'deploy:create_symlink', 'shared:configure'
before 'deploy:assets:precompile', 'shared:configure'
namespace :shared do
  task :configure, :roles => :app do
    run "mkdir -p #{shared_path}/shared"
    run "ln -s #{shared_path}/shared #{release_path}/shared"
  end
end

###################################################################################
# UNICORN (App Server)
###################################################################################

# before 'deploy:start',    'unicorn:configure'
# before 'deploy:restart',  'unicorn:configure'
after 'deploy:create_symlink', 'unicorn:configure'

set(:unicorn_pid) { "#{shared_path}/pids/unicorn.pid" }
# set(:unicorn_cmd) { "#{current_path}/bin/unicorn" }
set(:unicorn_cmd) { "cd #{current_path}; bundle exec unicorn" }
# set(:unicorn_cmd) { "#{release_path}/bin/unicorn_rails" }
set(:unicorn_config) { "#{current_path}/config/unicorn.rb" }
# set(:unicorn_config) { "#{release_path}/config/unicorn.rb" }

def unicorn_start_cmd
  "#{unicorn_cmd} -c #{unicorn_config} -E #{rails_env} -D"
end

def unicorn_stop_cmd
  # "kill -9 `cat #{unicorn_pid}`"
  "kill -QUIT `cat #{unicorn_pid}`"
end

def unicorn_restart_cmd
  "kill -USR2 `cat #{unicorn_pid}`"
  # "#{unicorn_stop_cmd}; #{unicorn_start_cmd}"
end

namespace :unicorn do
  # Signals: http://unicorn.bogomips.org/SIGNALS.html
  
  task :configure, :roles => :app do #, :except => {:no_release => true } do
    local_config = "./config/deploy/templates/unicorn.rb.erb"
    generate_config local_config, unicorn_config
  end
  
  # increment ammount of worker
  task :increment, :roles => :app, :except => {:no_release => true} do
    run "kill -TTIN `cat #{unicorn_pid}`"
  end
  
  # decrement ammount of worker
  task :decrement, :roles => :app, :except => {:no_release => true} do
    run "kill -TTOU `cat #{unicorn_pid}`"
  end
  
  task :start, :roles => :app, :except => {:no_release => true} do
    run unicorn_start_cmd
  end
  
  task :stop, :roles => :app, :except => {:no_release => true} do
    run unicorn_stop_cmd
  end
  
  task :restart, :roles => :app, :except => {:no_release => true} do
    run unicorn_restart_cmd
  end
  
  # Handling 'Old' unicorn (replaced by 'restart')
  task :stop_old_worker, :roles => :app, :except => {:no_release => true} do
    run "kill -WINCH `cat #{unicorn_pid}.oldbin`"
  end
  
  task :stop_old, :roles => :app, :except => {:no_release => true} do
    run "kill -QUIT `cat #{unicorn_pid}.oldbin`"
  end
  
  task :reload_old, :roles => :app, :except => {:no_release => true} do
    run "kill -HUP `cat #{unicorn_pid}.oldbin`"
  end
end


###################################################################################
# NGINX (Web Server)
###################################################################################
# before 'deploy:start',    'nginx:configure'
# before 'deploy:restart',  'nginx:configure'
after 'deploy:create_symlink', 'nginx:configure'

set :nginx_cmd, "/opt/nginx/sbin/nginx"

namespace :nginx do
  task :configure, :roles => :web do #, :except => {:no_release => true } do
    local_config  = "./config/deploy/templates/nginx.conf.erb"
    remote_config    = "#{shared_path}/nginx.conf"
    generate_config local_config, remote_config
  end
  
  task :configure_test, :roles => :web do
    set :user, 'root'
    test = capture("#{nginx_cmd} -t -c /etc/nginx/nginx.conf")
    puts test.green
  end
  
  task :restart, :roles => :web do
    set :user, 'root'
    run "service nginx restart"
  end
end

###################################################################################
# Worker (Sidekiq)
###################################################################################

# after 'deploy:create_symlink', 'sidekiq:configure'
# namespace :sidekiq do
#   task :configure, :roles => :app do
#     generate_config "./config/deploy/templates/sidekiq.yml.erb", "#{current_path}/config/sidekiq.yml"
#   end
# end

###################################################################################
# DATABASE
###################################################################################

# before "deploy:restart", "db:create_indexes"
# 
# namespace :db do
#   task :create_indexes do
#     run "cd #{release_path}; bundle exec rake db:create_indexes"
#   end
#   
#   task :dump_production do
#     return if stage == 'production'
#     return if rails_env == 'production'
#     run "cd #{current_path}; rm -rf tmp/db-dump; mongodump -o #{current_path}/tmp/db-dump -h localhost -d #{application}"
#     run "cd #{current_path}; mv tmp/db-dump/#{application} tmp/db-dump/#{application}_#{rails_env}"
#   end
# 
#   task :import_production do
#     return if stage == 'production'
#     return if rails_env == 'production'
#     run "mongo #{application}_#{rails_env} --eval 'db.dropDatabase()'"
#     run "mongorestore #{current_path}/tmp/db-dump"
#   end
#   
# end

###################################################################################
# Stats
###################################################################################

namespace :stats do
  task :disk do
    puts capture("df -h").green
  end
  
  # task :images do
  #   puts capture("du -sh #{shared_path}/log").green
  # end
  
  task :logs do
    puts capture("du -ah #{shared_path}/log").green
  end
end

###################################################################################
# SCREEN Tasks
###################################################################################

namespace :screen do
  task :sync_production_images do
    src   = "/home/salon/production/shared/system/files/"
    dest  = "#{shared_path}/system/files"
    cmd   = "rsync -rv #{src} #{dest}"
    
    ## rsync parameters
    # -p, --perms                 preserve permissions
    #     --executability         preserve executability
    #     --chmod=CHMOD           affect file and/or directory permissions
    # 
    # -o, --owner                 preserve owner (super-user only)
    # -g, --group                 preserve group
    #     --devices               preserve device files (super-user only)
    #     --specials              preserve special files
    
    cmd = "rsync -r --perms --executability #{src} #{dest}"
    run cmd
    # run "screen -t 'sync_images' bash -c '#{cmd}'"
    
    "rsync -r --perms --executability /home/salon/production/shared/system/files/ /home/salon/staging/shared/system/files"
  end
  
end



###################################################################################
# Logging
###################################################################################
# logger.level = Logger::IMPORTANT      # or Capistrano::Logger::IMPORTANT
# log_action "deploy:update_code", "Updating Code", 0, true
# log_action "bundle:install", "Install GEMs", 2
# log_action "deploy:assets:precompile", "Precompile Assets", 2
# log_action "deploy:create_symlink", "Create Symlinks"
# log_action "deploy:restart", "Restarting"
# log_action "deploy:start", "Start App-Server"
# 
# log_action "deploy:cleanup", "Cleaning Up"
# log_action "deploy:symlink", "Symlinking"

###################################################################################
# rake Tasks
###################################################################################

namespace :rake do  
  desc "Run a task on a remote server."  
  # run like: cap staging rake:invoke task=a_certain_task  
  task :invoke do  
    run("cd #{current_path}; bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}")  
  end  
end

###################################################################################
# Bootstrap
###################################################################################

namespace :bootstrap do
  task :install_redis do
    set :user, 'root'
    run "apt-get update; apt-get install redis-server"
  end
end

namespace :db do
  task :configure do
    run "cp -f #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
  
  desc 'Seed remote DB with local Data'
  task :seed do
    local = 'tmp/dump.rb'
    # system "bundle exec rake db:data:dump TABLES=members,pages,page_files"
    models = ['Page', 'Member']
    File.open(local, 'w') do |f|
      f.write "# encoding: utf-8\n"
      models.each do |m|
        f.write "#{m}.destroy_all\n"
      end
    end
    system "bundle exec rake db:seed:dump MODELS=#{models.join(',')} FILE=#{local} APPEND=true WITH_ID=1 TIMESTAMPS=1"
    upload local, "#{current_path}/db/seeds.rb", :via => :scp
    run("cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}")   
  end
end
after "deploy:finalize_update", "db:configure"

namespace :files do
  task :sync do
    src = 'public/system/'
    dest = "#{current_path}/public/system"
    #  --progress --stats
    cmd = "rsync --verbose --checksum --recursive #{src} #{user}@#{domain}:#{dest}"
    
    puts cmd
    system(cmd)
  end
end




