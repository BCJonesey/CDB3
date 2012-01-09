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
   
   test "prevent delete of user when it has members" do
     assert users(:darren).members.count >0
     exception = assert_raises RuntimeError do
      users(:darren).destroy
     end
     assert_equal "Cannot delete a user with members", exception.message
   end
end


