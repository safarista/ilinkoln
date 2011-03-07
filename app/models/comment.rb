class Comment < ActiveRecord::Base
  belongs_to  :post
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates   :body,      :presence => true
  validates   :commenter, :presence => true,
                          :length   => {:minimum => 4}
  validates   :email,     :presence => true,
                          :format   => {:with => email_regex }
  validates   :website,  :presence => true
end
