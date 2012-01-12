require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  fixtures :all

  test "should include MM" do
    get :index, {}, {:user_id => users(:nat).id}
    assert_response :success
    assert(@response.body.include?(games(:mirror_mirror).name), "No MM name")
  end

  test "should require logged in user" do
    get :index
    assert_response :redirect
    assert_not_nil flash[:notice]
  end

  test "should succeed with global admin" do
    get :new, {}, {:user_id => users(:nat).id}
    assert_response :success
  end

  test "should fail without global admin" do
    get :new, {}, {:user_id => users(:alex).id}
    assert_redirected_to '/'
    assert_equal flash[:alert], "Access denied: requires global admin"   
  end

  test "should display edit form" do
    get :edit, {:id => games(:mirror_mirror).id}, {:user_id => users(:nat).id}
    assert_response :success
    assert(@response.body.include?("<form"), "No form")
  end

  test "should display mirror mirror" do
    get :show, {:id => games(:mirror_mirror).id}, {:user_id => users(:nat).id}
    assert_response :success
    assert(@response.body.include?(games(:mirror_mirror).short_name), "No MM image")
  end

  test "should create new game" do
    post :create, {:game => {:name => "Created Game"}}, {:user_id => users(:nat).id}
    assert_response :redirect
    assert_not_nil Game.find_by_name("Created Game")
  end

  test "should update game" do
    post :update, {:id => games(:the_calling).id, 
        :game => {:id => games(:the_calling).id, :name => "Teh Colling"}},
      {:user_id => users(:nat).id}
    game = Game.find_by_name("Teh Colling")
    assert_equal game.id, games(:the_calling).id
  end

  test "should not destroy game without confirm" do 
    post :destroy, {:id => games(:the_calling).id}, {:user_id => users(:nat).id}
    assert_response :redirect
    assert_equal flash[:alert], "Must confirm game deletion"
    assert_not_nil Game.find_by_name("The Calling")    
  end

  test "should destroy game" do
    post :destroy, {:id => games(:the_calling).id, :confirm => "Yes"}, {:user_id => users(:nat).id}
    assert_response :redirect
    assert_nil Game.find_by_name("The Calling")    
  end
end
