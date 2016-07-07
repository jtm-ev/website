# require 'colored'
# require File.join File.dirname(__FILE__), 'deploy_helper'
# require 'bundler/capistrano'
# require 'sidekiq/capistrano'

set :stages, %w(production staging)
set :default_stage, 'staging'

set :deploy_via, :remote_cache
set :repository,  "git@github.com:jtm-ev/website.git"

set :ssl_csr, false
set :ssl_key, false

set :unicorn_workers, 2

# require 'capistrano/ext/multistage'

set :deploy_user,        "jtm"
set :application, "website"
set :domain,      "jtm.m1.relaunche.de"
set :port, 22

# ssh_options[:port] = 22
# ssh_options[:forward_agent] = true

set :use_sudo,    false
set :normalize_asset_timestamps, false


set :scm, :git

set :git_enable_submodules, 0

server 'jtm.de', user: 'jtm', roles: %w{web app db}

# role :app, fetch(:domain)
# role :web, fetch(:domain)
# role :db,  fetch(:domain), :primary => true

set :default_environment, {
  'PATH' => "/home/#{fetch(:deploy_user)}/.rbenv/shims:/home/#{fetch(:deploy_user)}/.rbenv/bin:$PATH"
}

# ###################################################################################
# # Default Deploy Hooks
# ###################################################################################

# namespace :deploy do
#   task(:stop, :roles => :app) {
#     run unicorn_stop_cmd
#   }

#   task(:restart, :roles => :app) {
#     run unicorn_restart_cmd
#   }

#   task(:start, :roles => :app) {
#     run unicorn_start_cmd
#   }
# end

# before 'bundle:install' do
#   run "cd #{release_path}; mv .rbenv-version.example .rbenv-version"
# end

# ###################################################################################
# # GEMs and ASSETs
# ###################################################################################

# set(:cd_bundle_cmd)  { "cd #{release_path}; bundle" }
# set(:bundle_path) {
#   "#{shared_path}/bundle"
# }

# namespace :bundle do
#   task :install do
#     run "#{cd_bundle_cmd} install --gemfile #{release_path}/Gemfile --path #{bundle_path} --without development test --binstubs" # --shebang ruby-local-exec"
#     # run "#{cd_bundle_cmd} install --gemfile #{release_path}/Gemfile --path #{bundle_path} --deployment --without development test --binstubs --shebang ruby-local-exec"
#   end
# end

# namespace :deploy do
#   namespace :assets do
#     task :precompile do
#       run "#{cd_bundle_cmd} exec rake RAILS_ENV=#{rails_env} RAILS_GROUPS=assets assets:precompile"
#     end
#   end
# end

# before 'deploy:assets:precompile', 'shared:configure'
# namespace :shared do
#   task :configure, :roles => :app do
#     run "mkdir -p #{shared_path}/shared"
#     run "ln -s #{shared_path}/shared #{release_path}/shared"
#   end
# end

# ###################################################################################
# # UNICORN (App Server)
# ###################################################################################

# after 'deploy:create_symlink', 'unicorn:configure'

# set(:unicorn_pid) { "#{shared_path}/pids/unicorn.pid" }
# def unicorn_worker_pid(worker)
#   unicorn_pid.sub('.pid', ".#{worker}.pid")
# end

# set(:unicorn_cmd) { "cd #{current_path}; bundle exec unicorn" }
# set(:unicorn_config) { "#{current_path}/config/unicorn.rb" }

# def unicorn_start_cmd
#   "#{unicorn_cmd} -c #{unicorn_config} -E #{rails_env} -D"
# end

# def unicorn_stop_cmd
#   # "kill -9 `cat #{unicorn_pid}`"
#   "kill -QUIT `cat #{unicorn_pid}`"
# end

# def unicorn_restart_cmd
#   "kill -USR2 `cat #{unicorn_pid}`"
#   # "#{unicorn_stop_cmd}; #{unicorn_start_cmd}"
# end

# namespace :unicorn do
#   # Signals: http://unicorn.bogomips.org/SIGNALS.html

#   task :configure, :roles => :app do #, :except => {:no_release => true } do
#     local_config = "./config/deploy/templates/unicorn.rb.erb"
#     generate_config local_config, unicorn_config
#   end

#   # increment ammount of worker
#   task :increment, :roles => :app, :except => {:no_release => true} do
#     run "kill -TTIN `cat #{unicorn_pid}`"
#   end

#   # decrement ammount of worker
#   task :decrement, :roles => :app, :except => {:no_release => true} do
#     run "kill -TTOU `cat #{unicorn_pid}`"
#   end

#   task :start, :roles => :app, :except => {:no_release => true} do
#     run unicorn_start_cmd
#   end

#   task :stop, :roles => :app, :except => {:no_release => true} do
#     run unicorn_stop_cmd
#   end

#   task :restart, :roles => :app, :except => {:no_release => true} do
#     run unicorn_restart_cmd
#   end

#   # Handling 'Old' unicorn (replaced by 'restart')
#   task :stop_old_worker, :roles => :app, :except => {:no_release => true} do
#     run "kill -WINCH `cat #{unicorn_pid}.oldbin`"
#   end

#   task :stop_old, :roles => :app, :except => {:no_release => true} do
#     run "kill -QUIT `cat #{unicorn_pid}.oldbin`"
#   end

#   task :reload_old, :roles => :app, :except => {:no_release => true} do
#     run "kill -HUP `cat #{unicorn_pid}.oldbin`"
#   end
# end


# ###################################################################################
# # NGINX (Web Server)
# ###################################################################################
# after 'deploy:create_symlink', 'nginx:configure'

# set :nginx_cmd, "/opt/nginx/sbin/nginx"

# namespace :nginx do
#   task :configure, :roles => :web do #, :except => {:no_release => true } do
#     local_config  = "./config/deploy/templates/nginx.conf.erb"
#     remote_config    = "#{shared_path}/nginx.conf"
#     generate_config local_config, remote_config
#   end

#   task :configure_test, :roles => :web do
#     set :user, 'root'
#     test = capture("#{nginx_cmd} -t -c /etc/nginx/nginx.conf")
#     puts test.green
#   end

#   task :restart, :roles => :web do
#     set :user, 'root'
#     run "service nginx restart"
#   end
# end

# ###################################################################################
# # Monit
# ###################################################################################
# namespace :monit do
#   task :configure do
#     set :user, 'root'
#     generate_config './config/deploy/templates/monit.conf.erb', "/etc/monit/conf.d/jtm.#{application}.#{rails_env}.monitrc"
#     # run 'service monit restart'
#     run 'monit reload'
#   end

#   task :configure_system do
#     set :user, 'root'
#     generate_config './config/deploy/templates/system.monit.conf.erb', "/etc/monit/conf.d/system.monitrc"
#     # run 'service monit restart'
#     run 'monit reload'
#   end

#   task :tunnel do
#     monit_port = 2812
#     # exec "ssh -g -R 2812:localhost:2812 root@#{domain} -p #{port}"
#     puts "Open Browser at: http://localhost:#{monit_port}".green
#     exec "ssh root@#{domain} -p #{port} -L #{monit_port}:localhost:#{monit_port}"
#   end
# end


# ###################################################################################
# # Stats
# ###################################################################################

# namespace :stats do
#   task :disk do
#     puts capture("df -h").green
#   end

#   # task :images do
#   #   puts capture("du -sh #{shared_path}/log").green
#   # end

#   task :logs do
#     puts capture("du -ah #{shared_path}/log").green
#   end
# end

# ###################################################################################
# # SCREEN Tasks
# ###################################################################################

# namespace :screen do
#   task :sync_production_images do
#     src   = "/home/salon/production/shared/system/files/"
#     dest  = "#{shared_path}/system/files"
#     cmd   = "rsync -rv #{src} #{dest}"

#     ## rsync parameters
#     # -p, --perms                 preserve permissions
#     #     --executability         preserve executability
#     #     --chmod=CHMOD           affect file and/or directory permissions
#     #
#     # -o, --owner                 preserve owner (super-user only)
#     # -g, --group                 preserve group
#     #     --devices               preserve device files (super-user only)
#     #     --specials              preserve special files

#     cmd = "rsync -r --perms --executability #{src} #{dest}"
#     run cmd
#     # run "screen -t 'sync_images' bash -c '#{cmd}'"

#     "rsync -r --perms --executability /home/salon/production/shared/system/files/ /home/salon/staging/shared/system/files"
#   end

# end


# ###################################################################################
# # rake Tasks
# ###################################################################################

# namespace :rake do
#   desc "Run a task on a remote server."
#   # run like: cap staging rake:invoke task=a_certain_task
#   task :invoke do
#     run("cd #{current_path}; bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}")
#   end
# end

# ###################################################################################
# # Bootstrap
# ###################################################################################

# namespace :bootstrap do
#   task :install_redis do
#     set :user, 'root'
#     run "apt-get update; apt-get install redis-server"
#   end
# end

# namespace :db do
#   task :configure do
#     run "cp -f #{shared_path}/database.yml #{release_path}/config/database.yml"
#   end

#   desc 'Seed remote DB with local Data'
#   task :seed do
#     local = 'tmp/dump.rb'
#     # system "bundle exec rake db:data:dump TABLES=members,pages,page_files"
#     # models = ['Page', 'Member', 'Group', 'GroupMembership', 'Location', 'Team', 'TeamMembership', 'Role']
#     models = ['Member', 'GroupMembership', 'Team', 'TeamMembership'] #'Page', 'Member', 'Group', 'GroupMembership', 'Team', 'TeamMembership', 'Role']
#     models.each do |m|
#       File.open(local, 'w') do |f|
#         f.write "# encoding: utf-8\n"
#         f.write "#{m}.delete_all\n"
#       end
#       system "bundle exec rake db:seed:dump MODELS=#{m} FILE=#{local} APPEND=true WITH_ID=1 TIMESTAMPS=1"
#       upload local, "#{current_path}/db/seeds.rb", :via => :scp
#       run("cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}")
#     end
#   end
# end
# after "deploy:finalize_update", "db:configure"

# task :configure do
#   ['email.yml', 'newrelic.yml'].each do |f|
#     run "cp -f #{deploy_to}/../#{f} #{release_path}/config/#{f}"
#   end
# end
# after "deploy:finalize_update", "configure"

# namespace :files do
#   task :sync do
#     src = 'public/system/'
#     dest = "#{current_path}/public/system"
#     #  --progress --stats
#     cmd = "rsync --verbose --checksum --recursive #{src} #{user}@#{domain}:#{dest}"

#     puts cmd
#     system(cmd)
#   end
# end

# namespace :rails do
#   desc "Open the rails console on one of the remote servers"
#   task :console, :roles => :app do
#     hostname = find_servers_for_task(current_task).first
#     exec "ssh -l #{user} #{hostname} -p #{port} -t 'PATH=/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH && cd #{current_path} && bin/rails c #{rails_env}'"
#   end
#   task :logs, :roles => :app do
#     hostname = find_servers_for_task(current_task).first
#     exec "ssh -l #{user} #{hostname} -p #{port} -t 'tail -f #{current_path}/log/#{rails_env}.log'"
#   end
# end


#############################################################################################################################

def mysqldump(stage, db_database, db_username, db_password, file)
  remote_file = "#{shared_path}/#{stage}_#{file}.sql"
  local_file = "tmp/#{stage}_#{file}.sql"

  on roles(:db) do
    params = "--add-drop-table -h localhost -u#{db_username} -p#{db_password} #{db_database} > #{remote_file}"
    execute :mysqldump, params
    download! remote_file, local_file
    # puts "CMD: #{params}"
  end
end

def remote_database_config(db)
  database = {}
  on roles(:db)do
    remote_config = capture("cat #{shared_path}/database.yml")
    database = YAML::load(remote_config)
  end
  return database["#{db}"]['username'], database["#{db}"]['password'], database["#{db}"]['database'], database["#{db}"]['host']
end


task :dump do
  stage = fetch(:rails_env)
  username, password, database, host = remote_database_config(stage)
  mysqldump(stage, database, username, password, 'jtm')
end

