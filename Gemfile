source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'yaml_db'
# gem 'mysql'

gem 'devise'
gem 'cancan'
gem 'rolify'

gem 'haml'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'
  gem 'bootstrap-sass'
  gem "jquery-fileupload-rails"
  gem "select2-rails"

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Image Upload / Processing
gem "paperclip", '3.4.0'
gem "paperclip-meta"

gem "acts_as_tree"
gem "acts-as-taggable-on"

gem "breadcrumbs_on_rails"
gem "liquid"

gem "geocoder"


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
gem 'jbuilder'

platforms :ruby do
  gem 'unicorn' # Use unicorn as the app server
  gem 'mysql2'
  gem 'activerecord-mysql-adapter'
end

platforms :mswin, :mingw do
  gem 'thin'
end

# Deploy with Capistrano
gem 'capistrano'
gem 'capistrano-ext'

# To use debugger
# gem 'debugger'

group :development do
  gem 'guard-livereload'  # livereload your browser on asset-changes (views, css)
  gem 'rack-livereload'
  gem 'rb-fsevent'
  
  gem 'term-ansicolor'    # Pretty printed test output
  gem 'quiet_assets'      # depress asset-pipeline-logs during development
  gem 'letter_opener'     # show sent emails in browser
end

