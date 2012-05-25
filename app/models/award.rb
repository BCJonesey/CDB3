class Award < ActiveRecord::Base
  belongs_to :character
  belongs_to :approved_by, :class_name => "Member"
  belongs_to :created_by, :class_name => "Member"
  belongs_to :currency
  has_one :game, :through => :character
  has_one :member, :through => :character
  
  validates :amount, :presence => true, :numericality => true
  validates :character_id, :presence => true
  validates :currency_id, :presence => true
  
  
  scope :pending, where(:approved_by_id =>nil)
  scope :approved, where("approved_by_id IS NOT NULL")
  
  
  
  
end
