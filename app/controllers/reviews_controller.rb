class ReviewsController < ApplicationController
  def index
    respond_with Review.due(current_user, params[:topic_id]) || {reviews: []}
  end

  # Make a new review
  def create
    # TODO write a mutation for this for when people give bad IDs, params etc.
    if Review.random_for(current_user, Topic.find(params[:topic_id]))
      render json: Review.due(current_user, params[:topic_id]), status: :created
    else
      raise ActiveRecord::RecordNotFound,
        'You got here because there were no facts left to review.'
    end
  end

  # Propose a response
  def update
    mutate Reviews::Update.run(params, user: current_user,
                                       review: Review.find(params[:id]))
  end
end
