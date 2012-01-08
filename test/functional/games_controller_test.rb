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
    assert_redirected_to '/'
    assert_equal flash[:alert], "Access denied: requires logged in user"
  end

  test "should succeed with global admin" do
    get :new, {}, {:user_id => users(:nat).id}
    assert_response :success
  end

  test "should fail without global admin" do
    get :new, {}, {:user_id => users(:steve).id}
    assert_redirected_to '/'
    assert_equal flash[:alert], "Access denied: requires global admin"   
  end
end
