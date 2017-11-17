class CharacterSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :character_version
  has_one :game, :through => :character_version
  validates :rank, :presence => true
  validates :character_version_id, :presence => true
  validates :skill_id, :presence => true, :uniqueness => { :scope => :character_version_id }
 

end


