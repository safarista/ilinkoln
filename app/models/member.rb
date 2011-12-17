class Member < ActiveRecord::Base
  has_many :posts
  attr_protected :admin
  
  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end
  def self.create_with_omniauth(auth)
    create! do |member|
      member.provider     = auth["provider"]
      member.uid          = auth["uid"]
      member.name         = auth["info"]["name"]
      member.location     = auth["info"]["location"]
      member.twitter      = auth["info"]["nickname"]
      member.description  = auth["info"]["description"]
      member.avatar       = auth["info"]["image"]
    end
  end
  
  def to_param
    "#{id}-#{slug}"
  end
  
  def slug
    self.name.downcase.gsub(/[^a-z0-9]/, '-')
  end
  
end
