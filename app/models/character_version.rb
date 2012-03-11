class CharacterVersion < ActiveRecord::Base
  has_many :character_skills, :dependent => :destroy
  belongs_to :previous_version, :class_name => :CharacterVersion, :dependent => :destroy 
  has_one :next_version, :class_name => :CharacterVersion, :foreign_key => :previous_version
  
  
end
