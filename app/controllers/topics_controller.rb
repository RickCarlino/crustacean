class TopicsController < ApplicationController
  def index
    respond_with Topic.all
  end

  def create
    outcome = Topics::Create.run(params)
    # TODO DRY this code up into a mutate() method or sth.
    if outcome.success?
      render json: outcome.result
    else
      render json: outcome.errors.message, status: 422
    end
  end
end
