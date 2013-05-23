class Award < ActiveRecord::Base
  belongs_to :character
  belongs_to :approved_by, :class_name => "Member"
  belongs_to :created_by, :class_name => "Member"
  belongs_to :currency
  has_one :game, :through => :member
  belongs_to :member
  
  validates :amount, :presence => true, :numericality => true
  validates :member_id, :presence => true
  validates :currency_id, :presence => true
  
  
  scope :pending, where(:approved_by_id =>nil)
  scope :approved, where("approved_by_id IS NOT NULL")
  scope :unassigned, where(:character_id => nil)
  
  
  
end
