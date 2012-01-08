require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "check user name" do
       assert "Darren Gagne" == users(:darren).name
   end
   
   test "prevent uppercase" do
     user = User.create({"email"=>"sssSS@g.com"})
   end
   
   test "ensure uniqe" do 
     user = User.create({"email"=>users(:darren).email})
     assert_not_equal user.errors.count , 0
   end
end
