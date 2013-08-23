class Character < ActiveRecord::Base
  belongs_to :character_version
  has_many :character_versions, dependent: :destroy
  has_many :awards, dependent: :destroy
  belongs_to :member
  has_one :game, :through => :member
  validates :name, :presence => true
  validates :member_id, :presence => true
  
  
  
  
  
  def new_version(old_version_desc)
    self.character_version = self.character_version.create_child_version(old_version_desc)
    self.save
    self.character_version
  end
  
  
  

  
  
  def get_or_create_version
    if character_version.nil?
      self.create_initial_version
    end
    self.character_version
  end
  
  
  
  
  def create_initial_version
    version = character_versions.build()   
    self.game.skills.default_skills.each do |skill|
      version.set_skill_rank(skill,rank.min_rank)
    end
    version.save
    self.character_version = version
    self.save
    self.new_version("New Character")
    self.save
  end
end
