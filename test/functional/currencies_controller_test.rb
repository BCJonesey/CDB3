require 'test_helper'

class CurrenciesControllerTest < ActionDispatch::IntegrationTest
  describe "CurrenciesController" do
    let(:game){FactoryBot.create(:game)}
    let(:user_password) {"123456"}
    let(:is_game_admin){false}
    let(:is_global_admin){false}
    let(:user){FactoryBot.create(:user, password: user_password)}
    let(:member) {FactoryBot.create(:member, game: game, user: user, game_admin: is_game_admin)}
    let(:user_session) { create_authenticated_session(user, user_password) }
    let(:currency){FactoryBot.create(:currency, game: game)}

    describe "game admin" do
      let(:is_game_admin){true}
      setup do
        user_session.get game_member_path(game, member)
      end
      test "should get index" do
        user_session.get game_currencies_path(game)
        user_session.assert_response :success
      end

      test "should get new" do
        user_session.get new_game_currency_path(game)
        user_session.assert_response :success
      end

      test "should create currency" do
        assert_difference('Currency.count') do
          user_session.post game_currencies_path(game), params: {currency: FactoryBot.attributes_for(:currency)}
        end

        user_session.assert_redirected_to game_currency_path(game, Currency.last)
      end

      test "should show currency" do
        user_session.get game_currency_path(game, currency)
        user_session.assert_response :success
      end

      test "should get edit" do
        user_session.get edit_game_currency_path(game, currency)
        user_session.assert_response :success
      end

      test "should update currency" do
        user_session.put game_currency_path(game,currency), params: {currency: {short_name: FactoryBot.attributes_for(:currency)[:short_name]}}
        user_session.assert_redirected_to game_currency_path(game, currency)
      end

      test "should destroy currency" do
        user_session.get game_currency_path(game, currency)
        assert_difference('Currency.count', -1) do
          user_session.delete game_currency_path(game,currency)
        end

        user_session.assert_redirected_to game_currencies_path(game)
      end
    end
    describe "game non-admin" do
      let(:is_game_admin){false}
      setup do
        user_session.get game_member_path(game, member)
      end
      test "should get index" do
        user_session.get game_currencies_path(game)
        user_session.assert_redirected_to game_path(game)
      end

      test "should get new" do
        user_session.get new_game_currency_path(game)
        user_session.assert_redirected_to game_path(game)
      end

      test "should create currency" do
        assert_difference('Currency.count', 0) do
          user_session.post game_currencies_path(game), params: {currency: FactoryBot.attributes_for(:currency)}
        end

        user_session.assert_redirected_to game_path(game)
      end

      test "should show currency" do
        user_session.get game_currency_path(game, currency)
        user_session.assert_redirected_to game_path(game)
      end

      test "should get edit" do
        user_session.get edit_game_currency_path(game, currency)
        user_session.assert_redirected_to game_path(game)
      end

      test "should update currency" do
        user_session.put game_currency_path(game,currency), params: {currency: {short_name: FactoryBot.attributes_for(:currency)[:short_name]}}
        user_session.assert_redirected_to game_path(game)
      end

      test "should destroy currency" do
        user_session.get game_currency_path(game, currency)
        assert_difference('Currency.count', 0) do
          user_session.delete game_currency_path(game,currency)
        end

        user_session.assert_redirected_to game_path(game)
      end
    end
  end
end
