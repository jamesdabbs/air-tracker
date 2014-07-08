class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  serialize :auth_data, JSON

  def self.find_for_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).
      create_with(auth_data: auth).
      first_or_create!
  end

  def auth
    Hashie::Mash.new auth_data
  end

  def name
    auth.info.name || raise("Could not find name in #{auth_info}")
  end

  def email
    auth.info.email || raise("Could not find email in #{auth_info}")
  end
end
