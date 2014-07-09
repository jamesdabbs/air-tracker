class Topic < ActiveRecord::Base
  belongs_to :user, foreign_key: "created_by"
  validates :title, presence: true
  validates :description, presence: true
  has_many :votes

  def short_description
  	description.first(140)
  end
end
