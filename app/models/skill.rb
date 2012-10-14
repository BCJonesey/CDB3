class Skill < ActiveRecord::Base
  has_many :skill_labels, :dependent => :delete_all
  has_many :provided_skill_labels, :class_name => "SkillLabel", :conditions => { :gives=>true}
  has_many :labels, :through => :skill_labels
  has_many :labels_provided,:class_name => "Label", :through => :provided_skill_labels, :source=>:label
  
  
  
  
  validates :name, :presence => true
  validates :game_id, :presence => true
  belongs_to :game
  validates :min_rank, :presence => true,:numericality =>{only_integer: true,  greater_than_or_equal_to: 0}
  validates :max_rank, :presence => true,:numericality =>{only_integer: true,  greater_than_or_equal_to: 1}
  
  
  scope :default_skills, where("min_rank > ?", 0)
end
