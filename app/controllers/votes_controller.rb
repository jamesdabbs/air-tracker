class VotesController < ApplicationController
  before_filter :authenticate_user!

  def create
    vote = current_user.votes.create topic_id: params[:topic_id], score: 1
    if vote.save
      flash[:success] = "Saved vote"
    else
      flash[:danger] = "You can only vote once"
    end
    redirect_to :back
  end

  def destroy
    vote = current_user.votes.where(topic_id: params[:topic_id]).first
    vote.destroy if vote
    flash[:info] = "Unvoted"
    redirect_to :back
  end
end
