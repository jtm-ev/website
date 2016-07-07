set :branch,      ENV['branch'] or "master"
set :rails_env,   "staging"
set :deploy_to,   "/home/#{fetch(:deploy_user)}/website/staging"
set :server_domain, "staging.jtm.m1.relaunche.de"


