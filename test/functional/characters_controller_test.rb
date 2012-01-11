require 'test_helper'

class CharactersControllerTest < ActionController::TestCase
  setup do
    @character = characters(:udo)
    @game      = games(:the_calling)
  end

  test "should get index" do
    get :index, {:game_id => @game.id}, {:user_id => users(:alex)}
    assert_response :success
    assert_not_nil assigns(:characters)
  end

  test "should get new" do
    get :new, {:game_id => @game.id}, {:user_id => users(:alex)}
    assert_response :success
  end

  test "should create character" do
    assert_difference('Character.count') do
      post :create, {:game_id => @game.id, character:
          {:member_id => members(:alex_calling).id, :name => "Bobby McNoob"}}, 
        {:user_id => users(:alex)}
    end

    assert_redirected_to game_character_path(@game, assigns(:character))
  end

  test "should show character" do
    get :show, {:game_id => @game.id, id: @character.to_param}, {:user_id => users(:alex)}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:game_id => @game.id, id: @character.to_param}, {:user_id => users(:alex)}
    assert_response :success
  end

  test "should update character" do
    put :update, {:game_id => @game.id, id: @character.to_param, character: @character.attributes},
      {:user_id => users(:alex)}
    assert_redirected_to game_character_path(@game, assigns(:character))
  end

  test "should destroy character" do
    assert_difference('Character.count', -1) do
      delete :destroy, {:game_id => @game.id, id: @character.to_param}, {:user_id => users(:alex)}
    end

    assert_redirected_to game_characters_path(@game)
  end
end
