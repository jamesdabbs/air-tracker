class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates :name, length: { maximum: 30 }, presence: true

  has_many :identities

  has_many :votes
  has_many :topics, foreign_key: "created_by"

  def avatar_url
    image_url || gravatar_url
  end

  def upvote(topic)
    vote = votes.where(topic: topic).first_or_initialize
    vote.update_attribute :score, 1
  end

  def downvote(topic)
    vote = votes.where(topic: topic).first_or_initialize
    vote.update_attribute :score, 0
  end

protected

  def confirmation_required?
    false
  end

  def gravatar_url
    default_url = "http://air-tracker.herokuapp.com/images/ruby-logo.png"
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
  end
end
