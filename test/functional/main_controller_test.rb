require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should error on bad account" do
    post :login, :post => { :email => 'bad_address@nowhere.gov' }
    assert_redirected_to '/'
    assert_nil session[:user_id]
    assert_equal flash[:alert], "No such user"
  end

end
