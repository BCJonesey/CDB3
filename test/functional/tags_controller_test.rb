require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest

  describe "TagsController" do
    let(:game){FactoryBot.create(:game)}
    let(:user_password) {"123456"}
    let(:is_game_admin){false}
    let(:is_global_admin){false}
    let(:user){FactoryBot.create(:user, password: user_password, global_admin: is_global_admin)}
    let(:member) {FactoryBot.create(:member, game: game, user: user, game_admin: is_game_admin)}
    let(:user_session) { create_authenticated_session(user, user_password) }
    let(:currency){FactoryBot.create(:currency, game: game)}
    let(:tag){FactoryBot.create(:tag,game: game)}


    describe "game admin" do
      let(:is_game_admin){true}

      setup do
        user_session.get game_member_path(game, member)
      end

      test "should get index" do
        user_session.get game_tags_path(game)
        user_session.assert_response :success
      end

      test "should get new" do
        user_session.get new_game_tag_path(game)
        user_session.assert_response :success
      end

      test "should create tag" do
        assert_difference('Tag.count', 1) do
          user_session.post game_tags_path(game), params: {tag: {name: "weak shit"}}
        end

        user_session.assert_redirected_to game_tag_path(game,Tag.last)
        assert_equal "weak shit", Tag.last.name
      end

      test "should show tag" do
        user_session.get game_tag_path(game, tag)
        user_session.assert_response :success
      end

      test "should get edit" do
        user_session.get edit_game_tag_path(game, tag)
        user_session.assert_response :success
      end

      test "should update tag" do
        user_session.put game_tag_path(game, tag), params:{tag: {name: "terrible name"}}
        user_session.assert_redirected_to game_tag_path(game,tag)
        tag.reload
        assert_equal "terrible name", tag.name
      end

      test "should destroy tag" do
        user_session.get game_tag_path(game, tag)
        assert_difference('Tag.count', -1) do
          user_session.delete game_tag_path(game, tag)
        end

        user_session.assert_redirected_to game_tags_path(game)
      end
    end
  end
end