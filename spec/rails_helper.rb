require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require 'capybara'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include(ObjectCreation)
  VCR.configure do |c|
    c.filter_sensitive_data("<ASIN_SECRET>") { ENV['ASIN_SECRET'] }
    c.filter_sensitive_data("<ASIN_KEY>") { ENV['ASIN_KEY'] }
    c.filter_sensitive_data("<ASIN_TAG>") { ENV['ASIN_TAG'] }
    c.cassette_library_dir = 'spec/vcr_cassettes'
    c.hook_into :webmock # or :fakeweb
    c.ignore_hosts 'codeclimate.com'
  end
  config.use_transactional_fixtures = true
  config.include(FeatureSupport)

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

end
