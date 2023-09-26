require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'simplecov'
SimpleCov.start

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
Dir[Rails.root.join('spec', 'shared_examples', '**', '*.rb')].each { |f| require f }

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

require_relative 'support/factory_bot'
require_relative 'support/request_helpers'
require_relative 'support/shoulda_matchers'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Request::AuthHelpers, type: :request
  config.include Request::AuthHelpers, type: :controller
end

SimpleCov.start do
  add_filter 'spec/support/matchers/http_status.rb'
  # add_filter 'lib/json_web_token.rb'
end
