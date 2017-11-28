require 'test_helper'

class CurrenciesControllerTest < ActionController::TestCase
  setup do
    @game   = FactoryBot.create(:game)
    @member = FactoryBot.create(:member,game: @game,game_admin: true)
    @user = @member.user
    @currency = FactoryBot.create(:currency,game: @game)
  end

  test "should get index" do
    get :index, {game_id: @game.id}, {:user_id => @user.id}
    assert_response :success
    assert_not_nil assigns(:currencies)
  end

  test "should get new" do
    get :new, {game_id: @game.id}, {:user_id => @user.id}
    assert_response :success
  end

  test "should create currency" do
    @currency.short_name = "KP"
    assert_difference('Currency.count') do
      post :create, {game_id: @game.id, currency: @currency.attributes}, {:user_id => @user.id}
    end

    assert_redirected_to game_currency_path(@game, assigns(:currency))
  end

  test "should show currency" do
    get :show, {id: @currency.to_param, game_id: @game.id}, {:user_id => @user.id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @currency.to_param, game_id: @game.id}, {:user_id => @user.id}
    assert_response :success
  end

  test "should update currency" do
    put :update, {id: @currency.to_param, game_id: @game.id, currency: @currency.attributes}, {:user_id => @user.id}
    assert_redirected_to game_currency_path(@game, @currency)
  end

  test "should destroy currency" do
    assert_difference('Currency.count', -1) do
      delete :destroy, {id: @currency.to_param, game_id: @game.id}, {:user_id => @user.id}
    end

    assert_redirected_to game_currencies_path
  end
end
