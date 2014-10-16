class ReviewsController < ApplicationController
  def index
    respond_with Review.due(current_user, params[:topic_id])
  end
end
