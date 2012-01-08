require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "check user name" do
       assert "Darren Gagne" == users(:darren).name
   end
end
