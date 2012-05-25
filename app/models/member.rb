class Member < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  has_many :characters
  has_many :awards, :through => :characters
  
  validates :user_id, :presence => true
  validates :game_id, :presence => true
  
  has_many :approved_awards, :class_name => "Award", :foreign_key => "approved_by_id"
  has_many :created_awards, :class_name => "Award", :foreign_key => "created_by_id"
  
  delegate :name, :email, :to=> :user
  

end
