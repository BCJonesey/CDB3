require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "check user name" do
    darren = FactoryGirl.build(:user, :name => "Darren")
    assert darren.name == "Darren"
  end
  
  test "prevent uppercase" do
    user = FactoryGirl.create(:user, :email => "sssSS@example.com")
    assert user.email == "sssss@example.com"
  end
  
  test "ensure unique" do 
    user = User.create({"email"=>Factory(:user).email})
    assert_not_equal user.errors.count, 0
  end
  
  test "prevent delete of user when it has members" do
    member = Factory(:member)

    exception = assert_raises RuntimeError do
      member.user.destroy
    end
    assert_equal "Cannot delete a user with members", exception.message
  end
end


