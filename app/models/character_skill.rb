class CharacterSkill < ActiveRecord::Base
  belongs_to :skill
  belongs_to :character_version
  
  validates :character_version_id, :presence => true
  validates :skill_id, :presence => true
  validates :rank, :presence => true,:numericality =>{only_integer: true,  greater_than: 0}
end
