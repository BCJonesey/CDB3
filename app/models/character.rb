class Character < ApplicationRecord
  belongs_to :character_version, optional: true
  has_many :character_versions, dependent: :destroy
  has_many :awards, dependent: :destroy
  belongs_to :member
  has_one :game, :through => :member
  has_many :character_skills, :through => :character_version
  validates :name, :presence => true
  validates :member_id, :presence => true
  
  
  
  
  
  def new_version(old_version_desc)
    self.character_version = self.character_version.create_child_version(old_version_desc)
    self.save
    self.character_version
  end
  
  
  

  
  
  def get_or_create_version
    if character_version.nil?
      self.create_initial_version
    end
    self.character_version
  end
  
  
  
  
  def create_initial_version
    version = character_versions.build()
    version.save
    self.character_version = version
    self.save
    self.new_version("New Character")
    self.save
  end

  def skill_rank(skill_id)
    character_version.skill_rank(skill_id)
  end

  def set_skill_rank(skill_id,rank)
    return character_version.set_skill_rank(skill_id,rank)
  end

  def currency_totals
    data_hash = {}
    res = awards.joins(:currency).group(:currency).sum(:amount)
    res.each do |currency, val|
      if currency.cap.nil?
        data_hash[currency.short_name] = val.to_f
      else
        data_hash[currency.short_name] = [val.to_f, currency.cap].min
      end
    end
    data_hash
  end

  def award_starting_currencies
    game.currencies.where.not(starting_amount: nil).each do |currency|
      awards.create({comment:"Starting Currency", currency: currency, amount: currency.starting_amount, member: member, approved_by: member, created_by: member})
    end
  end

  def game_rules
    {
      side_effects: self.game.side_effects
    }
  end

end