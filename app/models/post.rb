class Post < ActiveRecord::Base
  belongs_to  :member
  belongs_to  :category
  
  validates   :category_id, :presence => true
  validates   :body,        :presence => true 
  validates   :title ,      :presence => true,
                            :length   => { :minimum => 4 }
  
  has_many    :comments,    :dependent => :destroy
  
  def to_param
    "#{id}-#{slug}"
  end
  
  def slug
    self.title.downcase.gsub(/[^a-z0-9]/, '-')
  end
  
  
end
