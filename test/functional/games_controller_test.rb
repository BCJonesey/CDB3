require 'test_helper'

class GamesControllerTest < ActionController::TestCase
    setup do
    
    @admin = FactoryGirl.create(:user, global_admin: true)
    @user = FactoryGirl.create(:user)
   @mirror_mirror = FactoryGirl.create(:game_mirror_mirror)
  end


  test "should require logged in user" do
    get :index
    assert_response :redirect
    assert_not_nil flash[:alert]
  end

  test "should succeed with global admin" do
    get :new, {}, {:user_id => @admin.id}
    assert_response :success
  end

  test "should fail without global admin" do
    get :new, {}, {:user_id => @user.id}
    assert_redirected_to '/'
    assert_equal flash[:alert], "Access denied: requires global admin"   
  end

  test "should display edit form" do
    get :edit, {:id => @mirror_mirror.id}, {:user_id => @admin.id}
    assert_response :success
    assert(@response.body.include?("<form"), "No form")
  end

  test "should display mirror mirror" do
    get :show, {:id => @mirror_mirror.id}, {:user_id => @admin.id}
    assert_response :success
  end

  test "should create new game" do
    post :create, {:game => {:name => "Created Game",:slug => 'created'}}, {:user_id => @admin.id}
    assert_response :redirect
    assert_not_nil Game.find_by_name("Created Game")
  end

  test "should update game" do
    post :update, {:id => @mirror_mirror.id, 
        :game => {:id => @mirror_mirror.id, :name => "Teh Colling"}},
      {:user_id => @admin.id}
    game = Game.find_by_name("Teh Colling")
    assert_equal game.id, @mirror_mirror.id
  end

  test "should not destroy game without confirm" do 
    post :destroy, {:id => @mirror_mirror.id}, {:user_id => @admin.id}
    assert_response :redirect
    assert_equal flash[:alert], "Must confirm game deletion"
    assert_not_nil Game.find(@mirror_mirror.id)    
  end

  test "should destroy game" do
    post :destroy, {:id => @mirror_mirror.id, :confirm => "Yes"}, {:user_id => @admin.id}
    assert_response :redirect
    assert_nil Game.find_by_name(@mirror_mirror.name)    
  end
end
