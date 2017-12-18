require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  describe "CurrenciesController" do
    let(:game){FactoryBot.create(:game)}
    let(:user_password) {"123456"}
    let(:is_game_admin){false}
    let(:is_global_admin){false}
    let(:user){FactoryBot.create(:user, password: user_password, global_admin: is_global_admin)}
    let(:member) {FactoryBot.create(:member, game: game, user: user, game_admin: is_game_admin)}
    let(:user_session) { create_authenticated_session(user, user_password) }
    let(:currency){FactoryBot.create(:currency, game: game)}
    let(:user2){FactoryBot.create(:user, password: "sefasfdqwerqwerqwe", global_admin: false)}

    describe "global admin" do
      let(:is_global_admin){true}

      test "should get index" do
        user_session.get users_path
        user_session.assert_response :success
      end

      test "should get new" do
        user_session.get new_user_path
        user_session.assert_response :success
      end

      test "should create user" do
        user_session.get root_path

        assert_difference('User.count', 1) do
          user_session.post users_path, params:{user:{name: "poops mcgee", email: "killer@mike.com", password: "fgyhujkmnbghjkmnbh"}}
        end

        user_session2 = create_authenticated_session(User.last, "fgyhujkmnbghjkmnbh")
        user_session2.get game_path(game)
        user_session2.assert_response :success
      end

      test "should show user" do
        user_session.get user_path(user)
        user_session.assert_response :success
      end

      test "should get edit" do
        user_session.get edit_user_path(user)
        user_session.assert_response :success
      end

      test "should update user" do
        user_session.put user_path(user2), params:{user: {name: "Ruby Rod"}}
        user_session.assert_redirected_to user_path(user2)
      end

      test "should update own user" do
        user_session.put user_path(user), params:{user: {name: "Ruby Rod"}}
        user_session.assert_redirected_to root_path
      end

      test "should destroy user" do
        user_session.get user_path(user2)
        user_session.assert_response :success
        assert_difference('User.count', -1) do
          user_session.delete user_path(user2)
        end

        user_session.assert_redirected_to users_path
      end
      
      
      test "should create first user" do
        Member.destroy_all
        User.destroy_all
        post users_path, params: {"user" => {"name"=>"g man", "email"=>"bad_address@nowhere.gov", password: "ewwqrwerqwerqwer"}}
        assert_response(:redirect)
        assert_equal "g man", User.first.name
        assert_equal "bad_address@nowhere.gov",User.first.email
      end
    end
  end
end
