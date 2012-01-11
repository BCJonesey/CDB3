require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:mm_sept)
    @game  = games(:mirror_mirror)
  end

  test "should fail for non-admin" do
    get :index, {:game_id => @game.id}, {:user_id => users(:alex).id}
    assert_response :redirect
    assert_not_nil flash[:alert]
  end

  test "should get index" do
    get :index, {:game_id => @game.id}, {:user_id => users(:ben).id}
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new, {:game_id => @game.id}, {:user_id => users(:ben).id}
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, {:game_id => @game.id, event: 
        {:game_id => @game.id, :date => Time.now, :site => "Bacon" }}, {:user_id => users(:ben).id}
    end

    assert_redirected_to game_event_path(@game, assigns(:event))
  end

  test "should show event" do
    get :show, {:game_id => @game.id, id: @event.to_param}, {:user_id => users(:ben).id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:game_id => @game.id, id: @event.to_param}, {:user_id => users(:ben).id}
    assert_response :success
  end

  test "should update event" do
    put :update, {:game_id => @game.id, id: @event.to_param, event: @event.attributes}, 
      {:user_id => users(:ben).id}
    assert_redirected_to game_event_path(@game, assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, {:game_id => @game.id, id: @event.to_param}, {:user_id => users(:ben).id}
    end

    assert_redirected_to game_events_path(@game)
  end
end
