require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @member = members(:darren_calling)
    @game   = games(:the_calling)
  end

  test "should get index" do
    get :index, {:game_id => games(:the_calling).id}, {:user_id => users(:nat).id}
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get new" do
    get :new, {:game_id => games(:the_calling).id}, {:user_id => users(:nat).id}
    assert_response :success
  end

  test "should create member" do
    @game = games(:mirror_mirror)

    assert_difference('Member.count') do
      post :create, {:game_id => @game.id,
          member: {:game_id => @game.id, :user_id => users(:alex).id}}, 
        {:user_id => users(:nat).id}
    end

    assert_redirected_to game_member_path(@game, assigns(:member))
  end

  test "should show member" do
    get :show, {:game_id => games(:the_calling).id, id: @member.to_param}, 
      {:user_id => users(:nat).id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:game_id => games(:the_calling).id, id: @member.to_param}, 
      {:user_id => users(:nat).id}
    assert_response :success
  end

  test "should update member" do
    put :update, 
      {:game_id => games(:the_calling).id, id: @member.to_param, member: @member.attributes},
      {:user_id => users(:nat).id}
    assert_redirected_to game_member_path(@game, assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, 
        {:game_id => games(:the_calling).id, id: @member.to_param}, {:user_id => users(:nat).id}
    end

    assert_redirected_to game_members_path(@game)
  end
end
