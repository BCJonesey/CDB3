class Game < ActiveRecord::Base
  has_many :members
  has_many :events
  has_many :skills
  has_many :characters, :through => :members

  def short_name
    (name||'').downcase.sub(/\s/, '_')
  end

  def logo_image
    if short_name.empty?
      'main_logo.png'
    else
      short_name + '_logo.png'
    end
  end
end
