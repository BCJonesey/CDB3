class Registration < ApplicationRecord
  belongs_to :event
  belongs_to :member
  belongs_to :character, optional: true
  validates :event_id, :presence => true
  validates_uniqueness_of :event_id,:scope => :member_id
  
  
  scope :pcs, -> {where(:cp_game_id =>nil)}
  scope :npcs, -> {where("cp_game_id IS NOT NULL")}
  scope :prereged, -> {where(:prereged=>true)}
  scope :present, -> {where(:present=>true)}
  
  def waitlist_spot
    event.registrations.pcs.where("created_at < ?", created_at).count - event.player_cap
  end
  

end
