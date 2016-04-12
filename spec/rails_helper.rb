ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'factory_girl'
require 'factories'
require 'vcr'

ActiveRecord::Migration.maintain_test_schema!

VCR.configure do |config|
  config.cassette_library_dir = "specs/vcr_cassettes"
  config.hook_into :webmock
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryGirl::Syntax::Methods

  # Add VCR to all tests
  # config.around(:each) do |example|
  #   options = example.metadata[:vcr] || {}
  #   if options[:record] == :skip 
  #     VCR.turned_off(&example)
  #   else
  #     name = example.metadata[:full_description].split(/\s+/, 2).join('/').underscore.gsub(/\./,'/').gsub(/[^\w\/]+/, '_').gsub(/\/$/, '')
  #     VCR.use_cassette(name, options, &example)
  #   end
  # end
end
