class Api::V1::TopicsController < Api::V1::BaseController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find params[:id]
  end
end
