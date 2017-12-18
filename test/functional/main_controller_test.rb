require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest

  describe "MainController" do
    let(:user_password) {"123456"}
    let(:is_game_admin){false}
    let(:is_global_admin){false}
    let(:user){FactoryBot.create(:user, password: user_password, global_admin: is_global_admin)}
    let(:user_session) { create_authenticated_session(user, user_password) }


    setup do 
      FactoryBot.create(:user,global_admin: true)
    end

    test "should get index" do
      get root_path
      
      assert_response :success
    end
  end
end
