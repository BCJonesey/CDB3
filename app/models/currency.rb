class Currency < ActiveRecord::Base

  validates :short_name, :presence => true, :length => {:maximum => 5}
  validates :name, :presence => true, :length => {:maximum => 30}
  validates :cap, :numericality => {:greater_than => 0, :allow_blank => true}
  validates_uniqueness_of :short_name, :scope => :game_id
  validates_presence_of :game_id
  
  belongs_to :game
  
end
