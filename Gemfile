source 'https://rubygems.org'
source 'http://rubygems.nacyot.lapisan'

ruby '2.0.0'
gem 'rails', '4.0.0'

gem 'protected_attributes'
gem 'rails-observers'
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'activerecord-deprecated_finders'  

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# database
gem 'sqlite3'
gem 'ancestry'
gem 'pg'
gem 'activerecord-postgres-hstore', github: "engageis/activerecord-postgres-hstore", branch: "master"''

gem 'rails_admin', github: "sferik/rails_admin", branch: "rails-4"
#gem 'turbolinks'

# javascript
gem 'therubyracer'
gem 'execjs'
gem 'jquery-rails'

# gravatar
gem 'gravatar_image_tag' 

# authentication
gem 'devise'
gem 'cancan'
gem 'rolify'

# rails_admin
#gem 'rails_admin', git: 'git://github.com/swistaczek/rails_admin.git', branch: 'rails-4'

# view
gem 'twitter-bootstrap-rails'
gem 'simple_form'
gem 'kaminari'

# model view
gem 'draper'

# email
gem 'letter_opener'

# third-party
gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git"
gem 'piwik_analytics'
gem 'pry'
gem 'pry-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'paper_trail', github: 'airblade/paper_trail', branch: 'rails4'

# image handling
# 'dragonfly'

# state machine
# gem 'aasm'

# attachment
# gem 'carriewave'
# gem 'paperclip'

gem 'htmlentities'
gem 'faker'

# metrics
gem 'rails_best_practices'  
gem 'simplecov', :require => false
gem 'simplecov-rcov', :require => false
gem 'ci_reporter'
gem 'metric_fu'
#gem 'rcov', '0.9.11'
gem 'metric_fu_report_parser', github: 'nacyot/metric-fu-report-parser'

group  :development do
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
  # autotest
  #  gem 'ZenTest'
  #  gem 'autotest-rails'
  #  gem 'autotest-fsevent'
  #  gem 'autotest-growl'
  
  # rspec
  gem 'rspec'
  gem 'cucumber-rails', :require => false
  gem 'email_spec'
  gem 'webrat'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  # gem 'mongoid-rspec'
  
  # data
  gem 'factory_girl', :require => false
  gem 'factory_girl_rails', :require => false
end

group :development, :test do
  # rails warmer
  gem 'spring'
  # gem 'spork'
  
  # guard
  # gem 'guard-spork'
  gem 'guard-rspec'
  # gem 'guard-spring'
  gem 'guard-cucumber'
end

gem 'less-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'haml-rails'
gem 'uglifier', '>= 1.3.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
# To use Jbuilder templates for JSON


# Use unicorn as the app server
# gem 'unicorn'
# Deploy with Capistrano
# gem 'capistrano'
# To use debugger
# gem 'debugger'
