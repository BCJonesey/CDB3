require 'test_helper'

class CharactersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game      = FactoryBot.create(:game_the_calling)
    @user = FactoryBot.create(:user, password: "123456")
    @character = FactoryBot.create(:character, member: FactoryBot.create(:member, game: @game, user: @user))
    @user_session = create_authenticated_session(@user, "123456")
  end

  test "should get index" do
    @user_session.get game_characters_path(@game)
    @user_session.assert_response :success
  end

  test "should get new" do
    @user_session.get new_game_character_path(@game)
    @user_session.assert_response :success
  end

  test "should create character" do
    assert_difference('Character.count') do
      @user_session.post game_characters_path(@game), params: {character: {:member_id => @character.member.id, :name => "Bobby McNoob"}}
    end

    @user_session.assert_redirected_to game_character_path(@game, @game.characters.last)
  end

  test "should show character" do
    @user_session.get game_character_path(@game, @character)
    @user_session.assert_response :success
  end

  test "should get edit" do
    @user_session.get game_character_path(@game, @character)
    @user_session.assert_response :success
  end

  test "should update character" do
    @user_session.put game_character_path(@game, @character), params:{ character: @character.attributes}
    @user_session.assert_response :redirect
    @user_session.assert_redirected_to game_character_path(@game,  @character)
  end

  test "should not destroy character if the user is not an admin" do
    assert_difference('Character.count', 0) do
      @user_session.delete game_character_path(@game, @character)
    end
    @user_session.assert_response :redirect
    @user_session.assert_redirected_to game_path(@game)
  end

  test "should destroy character if the user is an admin" do
    @character.member.update(game_admin: true)
    assert_difference('Character.count', -1) do
      @user_session.delete game_character_path(@game, @character)
    end
    @user_session.assert_response :redirect
    @user_session.assert_redirected_to game_characters_path(@game)
  end
end
