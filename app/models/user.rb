class User < ActiveRecord::Base
  has_many :members
end
