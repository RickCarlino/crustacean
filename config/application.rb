require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Srs
  class Application < Rails::Application
    config.middleware.insert_before "ActionDispatch::Static", "Rack::Cors" do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :put, :post, :options, :delete]
      end
    end
  end
end
