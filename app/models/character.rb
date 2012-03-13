class Character < ActiveRecord::Base
  belongs_to :member
  has_one :game, :through => :member
  belongs_to :character_version, :dependent => :destroy
  delegate :character_skills, :to=> :character_version
  validates :name, :presence => true

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  #funky shit!
  alias :real_character_version :character_version
  def character_version
    if character_version_id.nil?
      self.character_version = CharacterVersion.create
      self.save
    end
    self.real_character_version
  end
  
end
