class SkillLabel < ActiveRecord::Base
  belongs_to :skill
  belongs_to :label
  
    
  validates :label_id, :presence => true
  validates :skill_id, :presence => true, :uniqueness => { :scope => :label_id }


end
