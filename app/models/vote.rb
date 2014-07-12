class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  validates :user_id, uniqueness: { scope: :topic_id }

  def upvote
  	update_attribute("score", 1)
  end

  def downvote
  	update_attribute("score", 0)
  end
end
