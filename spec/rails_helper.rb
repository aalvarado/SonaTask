ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'support/controller_macros'
require 'support/uploader_support'

ActiveRecord::Migration.maintain_test_schema!

FileUploader.include Support::UploaderSupport

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end


RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods

  config.include Devise::TestHelpers, type: :controller
  config.include Support::ControllerMacros, type: :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    FactoryGirl.lint
  end

  config.after(:suite) do
    Support::UploaderSupport.clean_uploads
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.before type: :controller do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  config.before file_path: /spec\/controllers\/api/ do
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end
end
