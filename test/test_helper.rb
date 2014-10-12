require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

ENV["RAILS_ENV"] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting

  # Add more helper methods to be used by all tests here...

  def topic
    @topic ||= FactoryGirl.create(:topic, :korean)
  end

  def create(*optns)
    FactoryGirl.create(*optns)
  end

  def build(*optns)
    FactoryGirl.build(*optns)
  end
end
