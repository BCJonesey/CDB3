class Game < ActiveRecord::Base
  has_many :members
  has_many :events
end
