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

  def downvote
    existing_vote = current_user.votes.where(topic_id: params[:topic_id]).first

    if existing_vote
      existing_vote.downvote
    else
      vote = current_user.votes.create topic_id: params[:topic_id], score: 0
      if !vote.save
        flash[ :danger ] = "Error creating vote"
        redirect_to :back
      end              
    end

    flash[:info] = "Downvoted"
    redirect_to :back
  end

  def upvote
    existing_vote = current_user.votes.where(topic_id: params[:topic_id]).first

    if existing_vote
      existing_vote.upvote
    else
      vote = current_user.votes.create topic_id: params[:topic_id], score: 1
      if !vote.save
        flash[ :danger ] = "Error creating vote"
        redirect_to :back
      end              
    end
    
    flash[:success] = "Upvoted"
    redirect_to :back
  end

end
