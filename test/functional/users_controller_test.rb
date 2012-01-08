require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "create first user" do
    User.destroy_all
    post :create, "user"=>{"name"=>"g man", "email"=>"bad_address@nowhere.gov"}
    assert_redirected_to '/'
    assert_nil session[:user_id]
    user = assigns(:user)
    assert_not_nil(user)
    assert_equal user.errors.count , 0
    assert_equal User.count, 1
    assert_equal user.name, "g man"
    assert_equal user.email,"bad_address@nowhere.gov"
  end
  
  test "create a user" do
    @request.env['HTTP_REFERER'] = '/users/new'
    post :create, "user"=>{"name"=>"g man", "email"=>"bad_address@nowhere.gov"}
    assert_redirected_to '/users/new'
    assert_nil session[:user_id]
    user = assigns(:user)
    assert_not_nil(user)
    assert_equal user.errors.count , 0
    assert_equal user.name, "g man"
    assert_equal user.email,"bad_address@nowhere.gov"
  end

end
