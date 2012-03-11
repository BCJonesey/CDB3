class Registration < ActiveRecord::Base
  belongs_to :event
  belongs_to :member
  belongs_to :character
  validates :event_id, :presence => true

end
