
def parse_config(file)
  require 'erb'  #render not available in Capistrano 2
  template=File.read(file)          # read it
  return ERB.new(template).result(binding)   # parse it
end

# Generates a configuration file parsing through ERB
# Fetches local file and uploads it to remote_file
# Make sure your user has the right permissions.
def generate_config(local_file, remote_file)
  temp_file = '/tmp/' + File.basename(local_file)
  buffer    = parse_config(local_file)
  File.open(temp_file, 'w+') { |f| f << buffer }
  upload temp_file, remote_file, :via => :scp
  `rm #{temp_file}`
end

STDOUT.sync
def log_action(hook, msg, indent = 0, skip_after = false)
  before hook do
    log = msg.ljust(25 - indent, '.').rjust(25)
    if skip_after
      puts log
    else
      print log
    end
  end
  
  unless skip_after
    after hook do
      puts "Done.".green
    end
  end
end












# desc "Run a task on a remote server: cap staging invoke_rake task=a_certain_task"  
# # run like: cap staging rake:invoke task=a_certain_task  
# task :invoke_rake do  
#   run("cd #{deploy_to}/current; bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}")  
# end
# 
