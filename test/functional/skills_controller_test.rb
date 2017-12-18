require 'test_helper'

class SkillsControllerTest  < ActionDispatch::IntegrationTest

  describe "SkillsController" do
    let(:game){FactoryBot.create(:game)}
    let(:user_password) {"123456"}
    let(:is_game_admin){false}
    let(:is_global_admin){false}
    let(:user){FactoryBot.create(:user, password: user_password, global_admin: is_global_admin)}
    let(:member) {FactoryBot.create(:member, game: game, user: user, game_admin: is_game_admin)}
    let(:user_session) { create_authenticated_session(user, user_password) }
    let(:currency){FactoryBot.create(:currency, game: game)}
    let(:tag){FactoryBot.create(:tag,game: game)}
    let(:skill){FactoryBot.create(:skill,game: game)}


    describe "game admin" do
      let(:is_game_admin){true}

      setup do
        user_session.get game_member_path(game, member)
      end

      test "should get index" do
        user_session.get game_skills_path(game)
        user_session.assert_response :success
      end

      test "should get new" do
        user_session.get new_game_skill_path(game)
        user_session.assert_response :success
      end

      test "should create skill" do
        assert_difference('Skill.count', 1) do
          user_session.post game_skills_path(game),  params: {skill:{name: "skill that thrillz"}}
        end
        assert_equal "skill that thrillz", Skill.last.name
        user_session.assert_redirected_to game_skills_path(game)
      end

      test "should show skill" do
        user_session.get game_skill_path(game, skill)
        user_session.assert_response :success
      end

      test "should get edit" do
        user_session.get edit_game_skill_path(game, skill)
        user_session.assert_response :success
      end

      test "should update skill" do
        user_session.put game_skill_path(game, skill), params: {skill: {name: "best skill"}}
        skill.reload
        assert_equal "best skill", skill.name
        user_session.assert_redirected_to game_skill_path(game, skill)
      end

      test "should destroy skill" do
        user_session.get game_skill_path(game, skill)
        assert_difference('Skill.count', -1) do
          user_session.delete game_skill_path(game, skill)
        end

        user_session.assert_redirected_to game_skills_path(game)
      end
    end
  end
end
