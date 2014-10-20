class FactsController < ApplicationController
  def create
    outcome = Facts::Create.run(fact_params)
    if outcome.success?
      render json: outcome.result
    else
      render json: outcome.errors.message, status: 422
    end
  end

private

  def fact_params
    {user: current_user,
     topic: Topic.find(params[:topic_id],
     fact: params)}
  end
end
