require 'coveralls'
Coveralls.wear!

require 'rubygems'

require 'factory_girl'
require 'factory_girl_rails'
# require 'simplecov'
# require 'simplecov-rcov'
# SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
# SimpleCov.start 'rails'    

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller

  config.before(:suite) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }

  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  
  ActiveSupport::Dependencies.clear

  def test_sign_in(user)
    controller.sign_in(user)
  end
end
