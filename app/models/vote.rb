class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  validates :user_id, uniqueness: { scope: :topic_id }
end
