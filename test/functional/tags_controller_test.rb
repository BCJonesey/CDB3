require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    

    @game = FactoryBot.create(:game_mirror_mirror)
    
    @tag = FactoryBot.create(:tag,game: @game)

    @member= FactoryBot.create(:member, game:@game,game_admin: true)
    @user=@member.user
  end


  test "should get index" do
    get :index, {:game_id=>@game.id},{:user_id=>@user.id}
    assert_response :success
    assert_not_nil assigns(:tags)
  end

  test "should get new" do
    get :new, {:game_id=>@game.id},{:user_id=>@user.id}
    assert_response :success
  end

  test "should create tag" do
    assert_difference('Tag.count') do
      @tag.name = @tag.name + @tag.name
      post :create, {:game_id=>@game.id,tag: @tag.attributes},{:user_id=>@user.id}
    end

    assert_redirected_to game_tag_path(@game,assigns(:tag))
  end

  test "should show tag" do
    get :show, {id: @tag.to_param,:game_id=>@game.id},{:user_id=>@user.id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @tag.to_param,:game_id=>@game.id},{:user_id=>@user.id}
    assert_response :success
  end

  test "should update tag" do
    put :update, {id: @tag.to_param,:game_id=>@game.id,skill: @tag.attributes},{:user_id=>@user.id} 
    assert_redirected_to game_tag_path(@game,assigns(:tag))
  end

  test "should destroy tag" do
    assert_difference('Tag.count', -1) do
      delete :destroy, {id: @tag.to_param,:game_id=>@game.id},{:user_id=>@user.id}
    end

    assert_redirected_to game_tags_path(@game)
  end
end
