require 'test_helper'

class MainControllerTest < ActionController::TestCase
  fixtures :all

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should error on bad account" do
    post :login, :email => 'bad_address@nowhere.gov'
    assert_response :redirect
    assert_nil session[:user_id]
    assert_equal flash[:alert], "No such user"
  end

  test "should login" do
    post :login, {:email => users(:nat).email, :game => games(:the_calling)}, 
    {:request_path => game_path(games(:the_calling))}
    assert session[:user_id] == users(:nat).id, "User id mismatch"
    assert_response :redirect
    assert_nil flash[:alert]
  end

  test "should logout" do
    get :logout, {}, { :user_id => users(:nat).id }
    assert_redirected_to '/'
  end
end
