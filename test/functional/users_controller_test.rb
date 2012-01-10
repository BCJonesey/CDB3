require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: @user.attributes
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user.to_param
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user.to_param, user: @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.to_param
    end

    assert_redirected_to users_path
  end
  
  
  test "should create first user" do
    Member.destroy_all
    User.destroy_all
    post :create, "user"=>{"name"=>"g man", "email"=>"bad_address@nowhere.gov"}
    assert_redirected_to '/'
    assert_equal User.first.name, "g man"
    assert_equal User.first.email,"bad_address@nowhere.gov"
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
    assert_equal flash[:alert], "A user with that email already exists"
    
  end
end
