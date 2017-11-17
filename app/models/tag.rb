class Tag < ApplicationRecord
  validates :name, :presence => true, :length => {:maximum => 30}
  validates_uniqueness_of :name, :scope => :game_id, :case_sensitive => false
  validates_presence_of :game_id
  
  belongs_to :game
  has_many :skills, :through => :skill_tags
  has_many :skill_tags, :dependent => :delete_all
  
  scope :by_game, lambda {|game| where(:game_id => game.id) }
  
  scope :unaffiliated_by_skill, lambda {|skill|  by_game(skill.game).where('id NOT IN (SELECT DISTINCT(tag_id) FROM skill_tags WHERE skill_id = ?)',skill.id) }
  
end
