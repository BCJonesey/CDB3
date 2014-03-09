class Skill < ActiveRecord::Base
  has_many :skill_tags, :dependent => :delete_all
  has_many :provided_skill_tags, :class_name => "SkillTag", :conditions => { :gives=>true}
  has_many :tags, :through => :skill_tags
  has_many :tags_provided,:class_name => "Tag", :through => :provided_skill_tags, :source=>:tag
  has_many :character_skills
  
  
  
  validates :name, :presence => true
  validates :game_id, :presence => true
  belongs_to :game
  validates :max_rank, :presence => true,:numericality =>{only_integer: true,  greater_than_or_equal_to: 1}
  
  

  def clean_up_data!
    if self.cost.length > 0
      self.cost = self.cost.gsub(/LT.spend\(/, "LT.spend(options,")
    end
    if self.rule.length > 0
      self.rule = self.rule.gsub(/LT.skill_rank\(/, "LT.skill_rank(options,")
    end
    self.save
  end

end
