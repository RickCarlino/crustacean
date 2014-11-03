require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

ENV["RAILS_ENV"] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

DocYoSelf.config do |c|
  c.template_file = 'test/template.md.erb'
  c.output_file   = 'api_docs.md'
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  def topic
    @topic ||= create(:korean_topic)
  end

  def user
    @user ||= create(:user)
  end

  def create(*optns)
    FactoryGirl.create(*optns)
  end

  def build(*optns)
    FactoryGirl.build(*optns)
  end

  def json
     JSON.parse(response.body).deep_symbolize_keys
  rescue
    raise 'Tried to parse JSON that was invalid. This is most likely caused by'\
      ' a broken controller response.'
  end
end

class ActionController::TestCase
  def teardown
    DocYoSelf.run!(request, response) if ENV['DOCS'].present?
    super
  end

  def note(msg)
    DocYoSelf.note(msg.squish)
  end
end

MiniTest::Unit.after_tests { DocYoSelf.finish! } if ENV['DOCS'].present?