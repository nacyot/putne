# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
ENV["SKIP_RAILS_ADMIN_INITIALIZER"] = "false"

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
