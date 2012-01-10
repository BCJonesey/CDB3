class Skill < ActiveRecord::Base
  validates :name, :presence => true
  validates :game_id, :presence => true
  belongs_to :game
end
