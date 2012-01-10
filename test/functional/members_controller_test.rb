require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @member = members(:darren_calling)
  end

  test "should get index" do
    get :index, {:game_id => games(:the_calling).id}, {:user_id => users(:nat).id}
    #assert_response :success
    #assert_not_nil assigns(:members)
  end

  test "should get new" do
    get :new, {}, {:user_id => users(:nat).id}
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post :create, {member: @member.attributes}, {:user_id => users(:nat).id}
    end

    assert_redirected_to member_path(assigns(:member))
  end

  test "should show member" do
    get :show, {id: @member.to_param}, {:user_id => users(:nat).id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @member.to_param}, {:user_id => users(:nat).id}
    assert_response :success
  end

  test "should update member" do
    put :update, {id: @member.to_param, member: @member.attributes},
      {:user_id => users(:nat).id}
    assert_redirected_to member_path(assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, {id: @member.to_param}, {:user_id => users(:nat).id}
    end

    assert_redirected_to members_path
  end
end
