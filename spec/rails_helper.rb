# spec/rails_helper.rb

# Require RSpec and any additional extensions or libraries you need
#require 'spec_helper'
require 'rspec/rails'
require 'rspec/rails'

# Define the RSpec configuration
RSpec.configure do |config|
  # Include Rails' route helpers and other integrations
  config.include Rails.application.routes.url_helpers

  # Set the transaction strategy to use transactions for each example
  config.use_transactional_fixtures = true

  # Use FactoryBot for test data factory creation
  config.include FactoryBot::Syntax::Methods

  # Use DatabaseCleaner to clean the database between test examples
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Set up any other RSpec configurations you need
end
