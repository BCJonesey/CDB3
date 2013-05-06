class Event < ActiveRecord::Base
  belongs_to :game
  has_many   :registrations

  validates_presence_of :game_id, :site, :start_date, :end_date
 
  scope :upcoming, lambda { where("end_date >= ?", Time.zone.now ) }
  scope :past, lambda { where("end_date < ?", Time.zone.now ) }
  
  def is_member_registered?(member)
    registrations.where(:member_id => member.id).count > 0
  end
  
end
