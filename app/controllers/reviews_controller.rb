class ReviewsController < ApplicationController
  def index
    respond_with Review.due(current_user, params[:topic_id])
  end

  # Make a new review
  def create
    # TODO write a mutation for this for when people give bad IDs, params etc.
    if Review.random_for(current_user, Topic.find(params[:topic_id]))
      respond_with Review.due(current_user, params[:topic_id])
    end
  end

  def update # Propose a response
    raise 'do this next.'
  end
end
