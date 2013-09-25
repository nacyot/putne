source 'http://rubygems.org'

# ruby '2.0.0'
gem 'rails', '4.0.0'

# Rails 3 compatibility
gem 'protected_attributes'
gem 'rails-observers'
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'activerecord-deprecated_finders'  

# database
gem 'pg'
gem 'activerecord-postgres-hstore', github: "engageis/activerecord-postgres-hstore", branch: "master"
gem 'acts-as-taggable-on'

# rails_admin
gem 'rails_admin', github: "sferik/rails_admin"

# javascript
gem 'therubyracer'
gem 'execjs'
gem 'jquery-rails'
gem 'json_builder', github: "dewski/json_builder"
gem 'rabl'


# gravatar
gem 'gravatar_image_tag' 

# dotenv
gem 'dotenv-rails'

# authentication
gem 'devise'

# authorization
gem 'cancan'
gem 'rolify'

# view
gem 'twitter-bootstrap-rails'
gem 'simple_form'
gem 'kaminari'

# model view
gem 'draper'

# email
gem 'letter_opener'

# console
gem 'pry'
gem 'debugger'
gem 'pry-rails'

# etc
gem 'htmlentities'

# third-party
gem 'coveralls', require: false

# server
gem 'sidekiq'
gem 'sinatra', require: false

# metrics
gem 'rails_best_practices'  
gem 'simplecov', :require => false
gem 'simplecov-rcov', :require => false
gem 'ci_reporter'
gem 'metric_fu'
gem 'churn', github: "danmayer/churn"
gem 'metric_fu_report_parser', github: 'nacyot/metric-fu-report-parser'
#gem 'rcov', '0.9.11'

# code highlight
gem 'coderay'

# ruby parser
gem 'parser'
gem 'ruby2ruby'

# git
gem 'gitlab-grit', '~>2.6.0', require: 'grit'

group  :development do
  gem 'rails-erd'
  gem 'erb2haml'
  gem 'annotate'
  gem 'rspec-rails'
  gem 'ruby_gntp'
  gem 'rb-fsevent'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'rack-mini-profiler'
  gem 'brakeman', :require => false
end

group :test do
  gem 'rspec'
  gem 'email_spec'
  gem 'webrat'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl', :require => false
  gem 'factory_girl_rails', :require => false
end

group :development, :test do
  gem 'spring'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'faker'
end

group :doc do
  gem 'sdoc', require: false
end

#assets
gem 'less-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'haml-rails'
gem 'uglifier', '>= 1.3.0'
gem 'slim'
