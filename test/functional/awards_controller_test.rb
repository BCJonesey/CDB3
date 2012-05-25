require 'test_helper'

class AwardsControllerTest < ActionController::TestCase
  setup do
     @game   = Factory(:game)
    @member = Factory(:member,game: @game,game_admin: true)
    @user = @member.user
    @character = Factory(:character, member: @member)
    @currency = Factory(:currency,game: @game)
    @award = Factory(:award,character: @character,currency: @currency, created_by: @member)
   
  end

  test "should get index" do
    get :index, {:game_id => @game.id}, {:user_id => @user.id}
    assert_response :success
    assert_not_nil assigns(:awards)
  end

  test "should get new" do
    get :new, {:game_id => @game.id}, {:user_id => @user.id}
    assert_response :success
  end

  test "should create award" do
    assert_difference('Award.count') do
      post :create, {award: @award.attributes, :game_id => @game.id}, {:user_id => @user.id}
    end

    assert_redirected_to game_award_path(@game,assigns(:award))
  end

  test "should show award" do
    get :show, {id: @award.to_param, :game_id => @game.id}, {:user_id => @user.id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @award.to_param, :game_id => @game.id}, {:user_id => @user.id}
    assert_response :success
  end

  test "should update award" do
    put :update, {id: @award.to_param, award: @award.attributes, :game_id => @game.id}, {:user_id => @user.id}
    assert_redirected_to game_award_path(@game,assigns(:award))
  end

  test "should destroy award" do
    assert_difference('Award.count', -1) do
      delete :destroy, {id: @award.to_param, :game_id => @game.id}, {:user_id => @user.id}
    end

    assert_redirected_to game_awards_path(@game)
  end
end
