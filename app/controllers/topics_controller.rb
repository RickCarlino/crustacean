class TopicsController < ApplicationController
  def index
    respond_with Topic.all
  end

  def show
    respond_with topic
  end

  def destroy
    topic.destroy
    respond_with(nil)
  end

private

  def topic
    @topic ||= Topic.find(params[:id])
  end
end
