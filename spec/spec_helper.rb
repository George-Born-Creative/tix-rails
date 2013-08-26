ENV["RAILS_ENV"] = 'test'
ENV['RACK_ENV'] = 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require "capybara/rspec"
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/app/**/*.rb"].each {|f| load f}
  Dir["#{Rails.root}/lib/**/*.rb"].each {|f| load f}

  # This code will be run each time you run your specs.
  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.include FactoryGirl::Syntax::Methods
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.infer_base_class_for_anonymous_controllers = false
  end
end
