class Event < ActiveRecord::Base
  belongs_to :game
  has_many   :registrations

  validates_presence_of :game_id, :site, :start_date, :end_date
 
end
