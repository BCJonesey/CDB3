require 'test_helper'

class SkillsControllerTest < ActionController::TestCase
  setup do
    @skill = skills(:one)
  end

  test "should get index" do
    get :index, {:game_id=>games(:mirror_mirror).id},{:user_id=>users(:nat).id}
    assert_response :success
    assert_not_nil assigns(:skills)
  end

  test "should get new" do
    get :new, {:game_id=>games(:mirror_mirror).id},{:user_id=>users(:nat).id}
    assert_response :success
  end

  test "should create skill" do
    assert_difference('Skill.count') do
      post :create, {:game_id=>games(:mirror_mirror).id,skill: @skill.attributes},{:user_id=>users(:nat).id}
    end

    assert_redirected_to game_skill_path(games(:mirror_mirror),assigns(:skill))
  end

  test "should show skill" do
    get :show, {id: @skill.to_param,:game_id=>games(:mirror_mirror).id},{:user_id=>users(:nat).id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @skill.to_param,:game_id=>games(:mirror_mirror).id},{:user_id=>users(:nat).id}
    assert_response :success
  end

  test "should update skill" do
    put :update, {id: @skill.to_param,:game_id=>games(:mirror_mirror).id,skill: @skill.attributes},{:user_id=>users(:nat).id} 
    assert_redirected_to game_skill_path(games(:mirror_mirror),assigns(:skill))
  end

  test "should destroy skill" do
    assert_difference('Skill.count', -1) do
      delete :destroy, {id: @skill.to_param,:game_id=>games(:mirror_mirror).id},{:user_id=>users(:nat).id}
    end

    assert_redirected_to game_skills_path(games(:mirror_mirror))
  end
end
