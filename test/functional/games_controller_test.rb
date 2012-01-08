require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "shoud include MM" do
    get :index
    assert_response :success
    assert(@response.body.include?(games(:mirror_mirror).name), "No MM name")

  end
end
