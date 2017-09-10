class Skill < ActiveRecord::Base
  has_many :skill_tags, :dependent => :delete_all
  has_many :provided_skill_tags, -> { where(gives: true) }, :class_name => "SkillTag"
  has_many :tags, :through => :skill_tags
  has_many :tags_provided,:class_name => "Tag", :through => :provided_skill_tags, :source=>:tag
  has_many :character_skills
  
  
  
  validates :name, :presence => true
  validates :game_id, :presence => true
  belongs_to :game
  validates :max_rank, :presence => true,:numericality =>{only_integer: true,  greater_than_or_equal_to: 1}
  

end
