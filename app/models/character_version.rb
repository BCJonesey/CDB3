class CharacterVersion < ActiveRecord::Base
  has_many :character_skills, :dependent => :destroy
  belongs_to :previous_version, :class_name => 'CharacterVersion', :inverse_of => :next_version
  has_one :next_version, :class_name => 'CharacterVersion', :foreign_key => 'previous_version_id', :inverse_of => :previous_version
  belongs_to :character
  has_one :game, :through => :character
  validates :character, :presence => true
  
  def set_skill_rank(skill,rank)
    
    if(rank>0)
      self.character_skills.find_or_create_by_skill(:skill=>skill,:rank=>rank)
    else
      self.character_skills.destroy_all(:skill=>skill)
    end
    
  end
  
  def create_child_version(old_version_desc)
    self.description = old_version_desc
    new_version = CharacterVersion.create
    new_version.previous_version_id = self.id
    new_version.character = self.character
    self.character_skills.includes(:skill).each do |character_skill|
      new_version.set_skill_rank(character_skill.skill,character_skill.rank)
    end
    new_version.save
    new_version
  end
  
  
  
  
  
  
end
