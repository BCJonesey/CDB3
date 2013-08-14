require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @game  = FactoryGirl.create(:game_mirror_mirror)
    @event = FactoryGirl.create(:event,game: @game)
    @member = FactoryGirl.create(:member,game: @game)
    @ben = FactoryGirl.create(:member,game: @game,game_admin: true)
    
  end

  test "should get index" do
    get :index, {:game_id => @game.id}, {:user_id => @ben.user.id}
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new, {:game_id => @game.id}, {:user_id => @ben.user.id}
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, {:game_id => @game.id, event: 
        {:game_id => @game.id, :start_date => DateTime.now, :end_date=>DateTime.now + 1.day,:site => "Bacon" }}, {:user_id => @ben.user.id}
    end

    assert_redirected_to game_event_path(@game, assigns(:event))
  end

  test "should show event" do
    get :show, {:game_id => @game.id, id: @event.to_param}, {:user_id => @ben.user.id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:game_id => @game.id, id: @event.to_param}, {:user_id => @ben.user.id}
    assert_response :success
  end

  test "should update event" do
    put :update, {:game_id => @game.id, id: @event.to_param, event: @event.attributes}, 
      {:user_id => @ben.user.id}
    assert_redirected_to game_event_path(@game, assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, {:game_id => @game.id, id: @event.to_param}, {:user_id => @ben.user.id}
    end

    assert_redirected_to game_events_path(@game)
  end
end
