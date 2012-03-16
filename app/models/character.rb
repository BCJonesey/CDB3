class Character < ActiveRecord::Base
  belongs_to :character_version, :dependent => :destroy
  #funky shit!
  alias :real_character_version :character_version

  
  belongs_to :member
  has_one :game, :through => :member
  delegate :character_skills, :to=> :character_version
  validates :name, :presence => true
  validates :member_id, :presence => true
  
  
  
  
  
  def new_version(old_version_desc)
    self.character_version = self.character_version.create_child_version(old_version_desc)
    self.save
    self.character_version
  end
  
  
  

  
  
  
  
  
  
  
  def character_version
    if character_version_id.nil?
      self.create_initial_version
    end   
    self.real_character_version
   
  end
  
  private
  def create_initial_version
    version = CharacterVersion.create()    
    self.game.skills.default_skills.each do |skill|
      version.set_skill_rank(skill,rank.min_rank)
    end
    self.real_character_version = version.new_version("New Character")
    self.save
  end
  
end
