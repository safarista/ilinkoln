class Member < ActiveRecord::Base
  has_many :posts
  attr_protected :admin
  
  def self.create_with_omniauth(auth)
    create! do |member|
      member.provider     = auth["provider"]
      member.uid          = auth["uid"]
      member.name         = auth["user_info"]["name"]
      member.location     = auth["user_info"]["location"]
      member.twitter      = auth["user_info"]["nickname"]
      member.description  = auth["user_info"]["description"]
      member.avatar       = auth["user_info"]["image"]
    end
  end
  
  def to_param
    "#{id}-#{slug}"
  end
  
  def slug
    self.name.downcase.gsub(/[^a-z0-9]/, '-')
  end
  
  # def self.authorize(id, admin)
  #   member = find_by_id(id)
  #   if member && member.admin ||= true
  #     member
  #   else
  #     nil
  #   end
  # end
end
