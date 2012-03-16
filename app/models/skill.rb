class Skill < ActiveRecord::Base
  validates :name, :presence => true
  validates :game_id, :presence => true
  belongs_to :game
  validates :min_rank, :presence => true,:numericality =>{only_integer: true,  greater_than_or_equal_to: 0}
  validates :max_rank, :presence => true,:numericality =>{only_integer: true,  greater_than_or_equal_to: 1}
  
  
  scope :default_skills, where("min_rank > ?", 0)
end
