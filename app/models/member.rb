class Member < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :characters
  has_many :awards
  
  validates :user_id, :presence => true
  validates :game_id, :presence => true
  
  has_many :approved_awards, :class_name => "Award", :foreign_key => "approved_by_id"
  has_many :created_awards, :class_name => "Award", :foreign_key => "created_by_id"
  
  delegate :name, :email, :to=> :user
  
  def is_admin
    game_admin || user.global_admin
  end

  def pending_awards
    self.awards.where(:approved_by_id => nil)
  end

  def unassigned_awards
    self.awards.where(:character_id => nil).where("approved_by_id IS NOT NULL")
  end
  
end
