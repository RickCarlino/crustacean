class FactsController < ApplicationController
  def create
    mutate Facts::Create.run(fact_params)
  end

private

  def fact_params
    {user: current_user,
     topic: Topic.joins(:questions).find(params[:topic_id]),
     answers: params[:answers]}
  end
end
