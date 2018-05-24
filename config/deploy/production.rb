set :branch,      "production"
set :rails_env,   "production"
set :deploy_to,   "/home/#{user}/website/production"
set :server_domain, "www.jtm.de jtm.de"
set :unicorn_workers, 8


# set :ssl_csr, "/path/to/cert_combined.crt"
# set :ssl_key, "/path/to/cert.key"

# set :deploy_via, :copy
# set :repository,  "./"
