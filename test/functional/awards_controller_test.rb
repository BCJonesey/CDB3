require 'test_helper'

class AwardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game   = FactoryBot.create(:game)
    @user = FactoryBot.create(:user, password: "123456")
    @member = FactoryBot.create(:member,game: @game,game_admin: true, user: @user)
    
    @character = FactoryBot.create(:character, member: @member)
    @currency = FactoryBot.create(:currency,game: @game)
    @award = FactoryBot.create(:award, member: @member, currency: @currency, created_by: @member)
    @user_session = create_authenticated_session(@user, "123456")
  end


  test "should get index" do
    @user_session.get game_awards_path(@game)
    @user_session.assert_response :success
  end

  test "should get new" do
    @user_session.get new_game_award_path(@game)
    @user_session.assert_response :success
  end

  test "should create award" do
    assert_difference('Award.count') do
      @user_session.post game_awards_path(@game), params: {award: @award.attributes}
    end

    @user_session.assert_redirected_to game_path(@game)
  end

  test "should show award" do
    @user_session.get game_award_path(@game, @award)
    @user_session.assert_response :success
  end

  test "should get edit" do
    @user_session.get edit_game_award_path(@game, @award)
    @user_session.assert_response :success
  end

  test "should update award" do
    @user_session.put game_award_path(@game, @award), params: {award: @award.attributes}
    @user_session.assert_redirected_to game_path(@game)
  end

  test "should destroy award" do
    assert_difference('Award.count', -1) do
      @user_session.delete game_award_path(@game, @award)
    end

    @user_session.assert_redirected_to game_path(@game)
  end
end
