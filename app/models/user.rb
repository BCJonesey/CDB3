class User < ActiveRecord::Base
  has_many :members
  validates :name, :presence => true
  validates :email, :presence => true,:uniqueness=>true,:format => {:with => /^[^A-Z]+$/} 
  before_validation :lower_email
  
  private 
  def lower_email
    self.email = self.email.downcase
  end
end
