class ApplicationController < ActionController::Base
  respond_to :json, default: :json
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
  before_filter :set_default_response_format

private

  def set_default_response_format
    request.format = :json
  end
end
