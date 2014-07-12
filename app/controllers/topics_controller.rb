class TopicsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def index
    @topics = Topic.page params[:page]
    @votes = current_user.votes.where(topic: @topics).
      each_with_object({}) { |v,h| h[v.topic] = v } if current_user
  end

  def new
    @topic = current_user.topics.new
  end

  def create
    @topic = current_user.topics.new create_params
    if @topic.save
      redirect_to @topic, flash: { success: "Created new topic: #{@topic.title}" }
    else
      render :new
    end
  end

  def show
    @topic = Topic.find params[:id]
  end

  private

  def create_params
    params.require(:topic).permit(:title, :description)
  end
end
