class CharacterSkill < ActiveRecord::Base
  belongs_to :skill
  belongs_to :character_version
  
  validates :character_version_id, :presence => true
  validates :skill_id, :presence => true, :uniqueness => { :scope => :character_version_id }
 

end


