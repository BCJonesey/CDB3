require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = registrations(:alex_tc_sept)
    @game = games(:the_calling)
  end

  test "should get index" do
    get :index, {:game_id => @game.id, :event_id => @registration.event_id}, 
      {:user_id => users(:alex).id}
    assert_response :success
    assert_not_nil assigns(:registrations)
  end

  test "should get new" do
    get :new, {:game_id => @game.id}, {:user_id => users(:alex).id}
    assert_response :success
  end

  test "should create registration" do
    assert_difference('Registration.count') do
      post :create, {registration: @registration.attributes, :game_id => @game.id}, 
        {:user_id => users(:alex).id}
    end

    assert_redirected_to game_registration_path(@game, assigns(:registration))
  end

  test "should show registration" do
    get :show, {id: @registration.to_param, :game_id => @game.id}, {:user_id => users(:alex).id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @registration.to_param, :game_id => @game.id}, {:user_id => users(:alex).id}
    assert_response :success
  end

  test "should update registration" do
    put :update, {id: @registration.to_param, registration: @registration.attributes, 
      :game_id => @game.id}, {:user_id => users(:alex).id}
    assert_redirected_to game_registration_path(@game, assigns(:registration))
  end

  test "should destroy registration" do
    assert_difference('Registration.count', -1) do
      delete :destroy, {id: @registration.to_param, :game_id => @game.id}, 
        {:user_id => users(:alex).id}
    end

    assert_redirected_to game_registrations_path(@game)
  end
end