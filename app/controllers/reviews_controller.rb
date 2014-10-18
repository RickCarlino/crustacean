class ReviewsController < ApplicationController
  def index
    respond_with Review.due(current_user, params[:topic_id])
  end

  # Make a new review
  def create
    # TODO write a mutation for this for when people give bad IDs, params etc.
    if Review.random_for(current_user, Topic.find(params[:topic_id]))
      respond_with Review.due(current_user, params[:topic_id])
    else
      raise 'You got here because there were no facts left to review.'
    end
  end

  # Propose a response
  def update
    outcome = Reviews::Update.run(params, user: current_user, review: review)
    if outcome.success?
      render json: outcome.result
    else
      render json: outcome.errors.message, status: 422
    end
  end

private

  def review
    @review ||= Review.find(params[:id])
  end
end
