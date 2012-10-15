class SkillTag < ActiveRecord::Base
  belongs_to :skill
  belongs_to :tag
  
    
  validates :tag_id, :presence => true
  validates :skill_id, :presence => true, :uniqueness => { :scope => :tag_id }


end
