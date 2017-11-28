require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user  = FactoryBot.create(:user)
    @user1 =  FactoryBot.create(:user)
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
    @user1.destroy

    assert_difference('User.count') do
      post :create, user: @user1.attributes
    end

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
      delete :destroy, id: @user1.to_param
    end

    assert_redirected_to users_path
  end
  
  
  test "should create first user" do
    Member.destroy_all
    User.destroy_all
    post :create, "user" => {"name"=>"g man", "email"=>"bad_address@nowhere.gov"}
    assert_response(:redirect)
    assert_equal "g man", User.first.name
    assert_equal "bad_address@nowhere.gov",User.first.email
  end
  

end
