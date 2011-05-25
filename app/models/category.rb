class Category < ActiveRecord::Base
  has_many :posts
  
  def to_param
    "#{id}-#{slug}"
  end
  
  def slug
    self.name.downcase.gsub(/[^a-z0-9]/, '-')
  end
end