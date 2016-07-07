# set :branch,      ENV['branch'] or "working_master"
set :branch,      "working_master"
set :rails_env,   "production"
set :deploy_to,   "/home/#{fetch(:deploy_user)}/website/production"
set :server_domain, "production.jtm.de production.jtm.m1.relaunche.de www.jtm.de jtm.de"
set :unicorn_workers, 8


# set :ssl_csr, "/path/to/cert_combined.crt"
# set :ssl_key, "/path/to/cert.key"

# set :deploy_via, :copy
# set :repository,  "./"
