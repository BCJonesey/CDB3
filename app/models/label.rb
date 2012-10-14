class Label < ActiveRecord::Base
  validates :name, :presence => true, :length => {:maximum => 30}
  validates_uniqueness_of :name, :scope => :game_id
  validates_presence_of :game_id
  
  belongs_to :game
  has_many :skills, :through => :skill_labels
  has_many :skill_labels, :dependent => :delete_all
  
  scope :by_game, lambda {|game| where(:game_id => game.id) }
  
  scope :unaffiliated_by_skill, lambda {|skill|  by_game(skill.game).where('id NOT IN (SELECT DISTINCT(label_id) FROM skill_labels WHERE skill_id = ?)',skill.id) }
  
end
