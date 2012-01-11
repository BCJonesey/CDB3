class Event < ActiveRecord::Base
  belongs_to :game
  has_many   :registrations

  validates :game_id, :presence => true
  validates :site, :presence => true
end
