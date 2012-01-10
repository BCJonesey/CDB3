require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "create first user" do
    Member.destroy_all
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
    user = User.last
    assert_equal "User has been created.",flash[:notice]
    assert_equal user.errors.count , 0
    assert_equal user.name, "g man"
    assert_equal user.email,"bad_address@nowhere.gov"
  end
  
  test "fail when trying to create a user with an existing email" do
    @request.env['HTTP_REFERER'] = '/users/new'
    post :create, "user"=>{"name"=>"g man", "email"=>users(:darren).email}
    assert_redirected_to '/users/new'
    assert_equal flash[:alert], "A user with that email already exists"
    
  end
  
  test "fail when trying to change email to one that is already in use" do
    @request.env['HTTP_REFERER'] = edit_user_path(users(:darren))
    post :update, {"id"=> users(:darren).id,"user"=>{"name"=>"g man", "email"=>users(:nat).email}}
    assert_redirected_to edit_user_path(users(:darren))
    assert_equal flash[:alert], "A user with that email already exists"
    
  end
  
  test "edit a user" do
    @request.env['HTTP_REFERER'] = users_path(users(:darren))
    post :update, {"id"=> users(:darren).id,"user"=>{"name"=>"g man", "email"=>users(:darren).email}}
    assert_redirected_to users_path(users(:darren))
    assert_equal flash[:notice], "User updated: g man"
    assert_equal  "g man",User.find(users(:darren)).name,
  end


end
