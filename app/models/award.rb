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
  
end
