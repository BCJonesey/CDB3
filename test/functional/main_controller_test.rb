require 'test_helper'

class MainControllerTest < ActionController::TestCase


  test "should get index" do
    FactoryBot.create(:user,global_admin: true)
    get :index
    
    assert_response :success
  end

  test "should error on bad account" do
    FactoryBot.create(:user,global_admin: true)
    post :login, :email => 'bad_address@nowhere.gov'
    assert_response :success
    assert_nil session[:user_id]
    assert_equal "No such user",flash[:alert]
  end

  test "should login" do
    @member = FactoryBot.create(:member)
    post :login, {:email => @member.user.email, :game => @member.game}, 
    {:request_path => game_path(@member.game)}
    assert session[:user_id] == @member.user.id, "User id mismatch"
    assert_response :redirect
    assert_nil flash[:alert]
  end

  test "should logout" do
    get :logout, {}, { :user_id => FactoryBot.create(:user).id }
    assert_redirected_to '/'
  end
end
