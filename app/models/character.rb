class Character < ActiveRecord::Base
  belongs_to :member
  has_one :game, :through => :member
  belongs_to :character_version, :dependent => :destroy
  has_many :character_skills, :through=>:character_version
  
  validates :name, :presence => true
  validates :character_version_id, :presence => true

end
