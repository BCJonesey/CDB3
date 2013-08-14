require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
     @game   = FactoryGirl.create(:game_the_calling)
    @member = FactoryGirl.create(:member,game:@game,game_admin: true)
    @user = @member.user
   
  end

  test "should get index" do
    get :index, {:game_id => @game.id}, {:user_id => @user.id}
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get new" do
    get :new, {:game_id => @game.id}, {:user_id => @member.user.id}
    assert_response :success
  end

  test "should create member" do
   

    assert_difference('@game.members.count') do
      post :create, {:game_id => @game.id,
          member: {:game_id => @game.id, :user_id => FactoryGirl.create(:user).id}}, 
        {:user_id => @user}
    end

    assert_redirected_to game_path(@game)
  end

  test "should show member" do
    get :show, {:game_id => @game.id, id: @member.id}, 
      {:user_id => @user}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {:game_id => @game.id, id: @member.id}, 
      {:user_id => FactoryGirl.create(:member,user: FactoryGirl.create(:user), game_admin: true,game:@game).user.id}
    assert_response :success
  end


  test "should destroy member" do
    assert_difference('@game.members.count', -1) do
      delete :destroy, 
        {:game_id => @game.id, id: @member.id}, {:user_id => @user}
    end

    assert_redirected_to game_members_path(@game)
  end
end
