require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  describe "SessionsController" do
    let(:user_password) {"123456"}
    let(:is_game_admin){false}
    let(:is_global_admin){false}
    let(:user){FactoryBot.create(:user, password: user_password, global_admin: is_global_admin)}
    let(:user_session) { create_authenticated_session(user, user_password) }


    setup do 
      FactoryBot.create(:user,global_admin: true)
    end

    test "should show the login page" do
        get login_path
        assert_response :success
    end

    test "should error on bad account" do
      post session_path, params:{:email => 'bad_address@nowhere.gov', password: 'efvwer3evcdwfr3ed'}
      assert_redirected_to login_path
    end

    test "should login" do
        post session_path, params:{:email => user.email, password: "123456"}
        assert_redirected_to root_path
    end

    test "should logout" do
      get logout_path
      assert_redirected_to '/'
    end
  end
end
