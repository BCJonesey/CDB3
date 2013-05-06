class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :member
  belongs_to :character
  validates :event_id, :presence => true
  validates_uniqueness_of :event_id,:scope => :member_id
  
  
  scope :pcs, where(:cp_to_game_id =>nil)
  scope :npcs, where("cp_to_game_id IS NOT NULL")
  scope :prereged, where(:prereged=>true)
  scope :present, where(:present=>true)
  
  
  

end
