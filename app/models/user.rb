class User < ActiveRecord::Base
  has_many :members
  has_many :games, :through => :members

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true , :format => {:with => /^[^A-Z]+$/} 
  before_validation :lower_email
  before_destroy :verify_no_members
  
  private 

  def name_and_email
    "#{name} - <#{email}>"
  end

  def lower_email
    self.email = self.email.downcase
  end

  def verify_no_members
    if self.members.count > 0
      raise "Cannot delete a user with members"
    end
  end
end
