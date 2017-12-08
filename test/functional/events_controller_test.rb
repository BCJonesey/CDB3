require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  describe "CurrenciesController" do
    let(:game){FactoryBot.create(:game)}
    let(:user_password) {"123456"}
    let(:is_game_admin){false}
    let(:is_global_admin){false}
    let(:user){FactoryBot.create(:user, password: user_password)}
    let(:member) {FactoryBot.create(:member, game: game, user: user, game_admin: is_game_admin)}
    let(:user_session) { create_authenticated_session(user, user_password) }
    let(:event){FactoryBot.create(:event, game: game)}
  
    describe "game admin" do
      let(:is_game_admin){true}
      setup do
        user_session.get game_member_path(game, member)
      end

      test "should get index" do
        user_session.get game_events_path(game)
        user_session.assert_response :success
      end

      test "should get new" do
        user_session.get new_game_event_path(game)
        user_session.assert_response :success
      end

      test "should create event" do
        assert_difference('Event.count', 1) do
          user_session.post game_events_path(game), params: {event: 
          {:start_date => DateTime.now, :end_date=>DateTime.now + 1.day, :site => "Bacon", :player_cap => 22 }}
        end
        user_session.assert_redirected_to game_event_path(game, Event.last)
      end

      test "should show event" do
        user_session.get game_event_path(game, event)
        user_session.assert_response :success
      end

      test "should get edit" do
        user_session.get edit_game_event_path(game, event)
        user_session.assert_response :success
      end

      test "should update event" do
        user_session.put game_event_path(game, event), params: {event: {player_cap: 55}}
        user_session.assert_redirected_to game_event_path(game, event)
        event.reload
        assert event.player_cap == 55
      end

      test "should destroy event" do
        user_session.get game_event_path(game, event)
        assert_difference('Event.count', -1) do
          user_session.delete game_event_path(game, event)
        end

        user_session.assert_redirected_to game_events_path(game)
      end
    end
    describe "game admin" do
      let(:is_game_admin){false}
      setup do
        user_session.get game_member_path(game, member)
      end

      test "should get index" do
        user_session.get game_events_path(game)
        user_session.assert_response :success
      end

      test "should get new" do
        user_session.get new_game_event_path(game)
        user_session.assert_redirected_to game_path(game)
      end

      test "should create event" do
        assert_difference('Event.count', 0) do
          user_session.post game_events_path(game), params: {event: 
          {:start_date => DateTime.now, :end_date=>DateTime.now + 1.day, :site => "Bacon", :player_cap => 22 }}
        end
        user_session.assert_redirected_to game_path(game)
      end

      test "should show event" do
        user_session.get game_event_path(game, event)
        user_session.assert_response :success
      end

      test "should get edit" do
        user_session.get edit_game_event_path(game, event)
        user_session.assert_redirected_to game_path(game)
      end

      test "should update event" do
        user_session.put game_event_path(game, event), params: {event: {player_cap: 55}}
        user_session.assert_redirected_to game_path(game)
        event.reload
        assert event.player_cap == 33
      end

      test "should destroy event" do
        user_session.get game_event_path(game, event)
        assert_difference('Event.count', 0) do
          user_session.delete game_event_path(game, event)
        end

        user_session.assert_redirected_to game_path(game)
      end
    end
  end
end
