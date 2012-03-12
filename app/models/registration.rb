class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :member
  belongs_to :character
  validates :event_id, :presence => true
  
  
  scope :pcs, where(:cp_to_game_id =>nil)
  scope :npcs, where("cp_to_game_id IS NOT NULL")
  scope :prereged, where(:prereged=>true)
  scope :present, where(:present=>true)
  
  
  

end
