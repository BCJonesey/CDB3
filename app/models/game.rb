class Game < ActiveRecord::Base
  has_many :members
  has_many :events
  has_many :currencies
  has_many :skills
  has_many :tags
  has_many :characters, :through => :members
  has_many :awards, :through => :members
  has_many :character_skills, :through => :characters
  
  validates :name, :presence => true, :uniqueness => true
  validates :slug, :presence => true, :uniqueness => true
  
  extend FriendlyId
  friendly_id :slug, use: [:finders]

  def logo_image
    logo = self.name + '_logo.png'
    
    if File.exists?(Rails.root + "app/assets/images/" + logo)
      logo
    else
      'main_logo.png'
    end
  end
end
