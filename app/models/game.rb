class Game < ActiveRecord::Base
  has_many :members
  has_many :events
  has_many :currencies
  has_many :skills
  has_many :characters, :through => :members
end
