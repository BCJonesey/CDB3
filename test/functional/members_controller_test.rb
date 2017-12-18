require 'test_helper'

class MembersControllerTest  < ActionDispatch::IntegrationTest
  describe "CurrenciesController" do
    let(:game){FactoryBot.create(:game)}
    let(:user_password) {"123456"}
    let(:is_game_admin){false}
    let(:is_global_admin){false}
    let(:user){FactoryBot.create(:user, password: user_password, global_admin: is_global_admin)}
    let(:member) {FactoryBot.create(:member, game: game, user: user, game_admin: is_game_admin)}
    let(:user_session) { create_authenticated_session(user, user_password) }

    test "join as a member" do
      assert_difference('game.members.count', 1) do
        user_session.post game_members_path(game)
      end
      assert_not_nil Member.find_by_game_id_and_user_id(game.id, user.id)
    end

    describe "Game Admin" do
      let(:is_game_admin){true}

      setup do
        Member.find(member.id)
      end

      test "should get index" do
        user_session.get game_members_path(game)
        user_session.assert_response :success
      end

      test "should show own member" do
        user_session.get game_member_path(game, member)
        user_session.assert_response :success
      end

      test "should show other member" do
        member2 = FactoryBot.create(:member, game: game)
        user_session.get game_member_path(game, member2)
        user_session.assert_response :success
      end

      test "should get edit" do
        user_session.get edit_game_member_path(game, member)
        user_session.assert_response :success
      end


      test "should destroy other member" do
        member2 = FactoryBot.create(:member, game: game)
        assert_difference('game.members.count', -1) do
          user_session.delete game_member_path(game, member2)
        end
        user_session.assert_redirected_to game_members_path(game)
      end
    end
  end
end
