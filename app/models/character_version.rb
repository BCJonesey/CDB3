class CharacterVersion < ActiveRecord::Base
  has_many :character_skills, :dependent => :destroy
  belongs_to :previous_version, :class_name => :CharacterVersion, :dependent => :destroy 
  has_one :next_version, :class_name => :CharacterVersion, :foreign_key => :previous_version
  
  
  def set_skill_rank(skill,rank)
    
    if(rank>0)
      self.character_skills.find_or_create_by_skill(:skill=>skill,:rank=>rank)
    else
      self.character_skills.destroy_all(:skill=>skill)
    end
    
  end
  
  def create_child_version(old_version_desc)
    self.description = old_version_desc
    new_version = CharacterVersion.create(:previous_version => self.character_version)
    self.character_skills.includes(:skill).each do |character_skill|
      version.set_skill_rank(character_skill.skill,character_skill.rank)
    end
    new_version
  end
  
  
  
  
  
  
end
