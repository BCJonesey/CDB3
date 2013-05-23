class Character < ActiveRecord::Base
  before_destroy :delete_versions
  belongs_to :real_character_version, :class_name => 'CharacterVersion', :foreign_key => 'character_version_id'


  has_many :awards
  belongs_to :member
  has_one :game, :through => :member
  delegate :character_skills, :to=> :character_version
  validates :name, :presence => true
  validates :member_id, :presence => true
  
  
  
  
  
  def new_version(old_version_desc)
    self.real_character_version = self.real_character_version.create_child_version(old_version_desc)
    self.save
    self.character_version
  end
  
  
  

  
  
  
  
  
  
  
  def character_version
    if character_version_id.nil?
      self.create_initial_version
    end   
    self.real_character_version
   
  end
  
  
  def create_initial_version
    version = CharacterVersion.create()    
    self.game.skills.default_skills.each do |skill|
      version.set_skill_rank(skill,rank.min_rank)
    end
    version.save
    self.character_version_id = version.id
    self.save
    self.new_version("New Character")
    self.save
  end
  private
  def delete_versions
      while self.real_character_version != nil  do
	version = self.real_character_version
	self.real_character_version = self.real_character_version.previous_version
	version.destroy
      end
  end
  
end
