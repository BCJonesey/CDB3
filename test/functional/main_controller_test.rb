require 'test_helper'

class MainControllerTest < ActionController::TestCase
  fixtures :all

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should error on bad account" do
    post :login, :email => 'bad_address@nowhere.gov'
    assert_redirected_to '/'
    assert_nil session[:user_id]
    assert_equal flash[:alert], "No such user"
  end

  test "should login" do
    post :login, :email => 'nat@ferrus.net'
    assert session[:user_id] == users(:nat).id, "User id mismatch"
    assert_response :success
    assert_nil flash[:alert]
  end

  test "should logout" do
    get :logout, {}, { :user_id => users(:nat).id }
    assert_redirected_to '/'
  end
end
