class Character < ActiveRecord::Base
  belongs_to :member
  has_one :game, :through => :member
  validates :name, :presence => true

end
