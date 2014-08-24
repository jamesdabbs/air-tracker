class Topic < ActiveRecord::Base
  belongs_to :creator, foreign_key: "created_by", class_name: "User"

  validates :title, presence: true
  validates :description, presence: true

  has_many :votes

  scope :scheduled,   -> { where("scheduled_for IS NOT NULL") }
  scope :unscheduled, -> { where("scheduled_for IS NULL")     }

  def score
    votes.reduce(0) { |sum, v| sum + v.score }
  end

  def short_description
    description.first(140)
  end
end
