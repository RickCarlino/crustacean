class TopicsController < ApplicationController
  def index
    respond_with Topic.all
  end
end
