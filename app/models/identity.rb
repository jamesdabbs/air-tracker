class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  serialize :auth_data, JSON

  def auth
    Hashie::Mash.new auth_data
  end

  %w(name email image).each do |attr|
    define_method attr do
      auth.info.send(attr) || raise("Could not find #{attr} in #{auth}")
    end
  end
end
