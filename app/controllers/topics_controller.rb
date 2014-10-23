class TopicsController < ApplicationController
  def index
    respond_with Topic.all
  end

  def create
    mutate Topics::Create.run(params)
  end
end
