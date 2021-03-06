class ApplicationController < ActionController::Base
  respond_to :json, default: :json
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  before_action :set_default_response_format
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :four_oh_four

private

  def mutate(outcome)
    if outcome.success?
      render json: outcome.result
    else
      render json: outcome.errors.message, status: 422
    end
  end

  def authenticate_user!
    @current_user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    respond_with({error: 'Unauthorized. Provide a user_id in payload.'},
                 status: 401)
  end

  def four_oh_four(exception)
    render json: {error: "Not found. #{exception.message}"}, status: 404
  end

  # Totally insecure "authentication" scheme.
  def current_user
    @current_user ||= User.find(params[:user_id])
  end

  def set_default_response_format
    request.format = :json
  end
end
