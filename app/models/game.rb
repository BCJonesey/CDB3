class Game < ActiveRecord::Base
  has_many :members
  has_many :events
  has_many :skills
end
