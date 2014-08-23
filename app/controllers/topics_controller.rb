class TopicsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_topic, only: [:show, :upvote, :downvote]

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
  end

  def upvote
    current_user.upvote @topic
    redirect_to :back
  end

  def downvote
    current_user.downvote @topic
    redirect_to :back
  end

private

  def find_topic
    @topic = Topic.find params[:id]
  end

  def create_params
    params.require(:topic).permit(:title, :description)
  end
end
