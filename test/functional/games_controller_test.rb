require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  describe "CurrenciesController" do
    let(:game){FactoryBot.create(:game)}
    let(:user_password) {"123456"}
    let(:is_game_admin){false}
    let(:is_global_admin){false}
    let(:user){FactoryBot.create(:user, password: user_password, global_admin: is_global_admin)}
    let(:member) {FactoryBot.create(:member, game: game, user: user, game_admin: is_game_admin)}
    let(:user_session) { create_authenticated_session(user, user_password) }


    describe "global admin" do

      let(:is_global_admin){true}

      test "should show new game page" do
        user_session.get new_game_path
        user_session.assert_response :success
      end

      test "should show games" do
        user_session.get games_path
        user_session.assert_response :success
      end

      test "should display edit form" do
        user_session.get edit_game_path(game)
        user_session.assert_response :success
      end

      test "should create new game" do
        user_session.post games_path, params: {:game => {:name => "Created Game",:slug => 'created'}}
        assert_not_nil Game.find_by_name("Created Game")
        user_session.assert_redirected_to game_path(Game.find_by_name("Created Game"))
      end

      test "should update game" do
        user_session.put game_path(game), params: {game:{name: "Teh Colling"}}
        assert_equal game.id,Game.find_by_name("Teh Colling").id
        user_session.assert_redirected_to game_path(game)
      end

      test "should not destroy game without confirm" do 
        user_session.delete game_path(game)
        user_session.assert_redirected_to game_path(game)
        assert_not_nil Game.find(game.id)    
      end

      test "should destroy game" do
        user_session.delete game_path(game), params: {:confirm => "Yes"}
        user_session.assert_redirected_to games_path
        assert_raises(ActiveRecord::RecordNotFound) do
          Game.find(game.id)
        end
      end
    end
  end
end
