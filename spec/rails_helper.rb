ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_run_excluding :performance => true

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.reload
  end

  config.before(performance: true) do
    ActionController::Base.perform_caching = true
    ActiveSupport::Dependencies.mechanism = :require
    Rails.logger.level = ActiveSupport::Logger::INFO
  end

  config.after do
    Rails.application.config.baukis[:restrict_ip_addresses] = false
  end
end
