require 'rubygems'
require 'database_cleaner'
require 'mocha/api'
require 'support/controller_helpers'
require 'devise'

RSpec.configure do |config|
  config.mock_with :mocha
  config.include ControllerHelpers, type: :controller
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    #mocks.allow_message_expectations_on_nil = false
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    #DatabaseCleaner.clean_with(:deletion)
    #  This are needed before a user can be created or lo
    Role.create!(name: "admin")
    Role.create!(name: "user")
  end
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    #DatabaseCleaner.strategy = :deletion
  end
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    FileUtils.rm_rf( Rails.root.join("images","test_images"))
    # DatabaseCleaner.clean
  end
end
