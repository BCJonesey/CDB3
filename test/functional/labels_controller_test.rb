require 'test_helper'

class LabelsControllerTest < ActionController::TestCase
  setup do
    

    @game = FactoryGirl.create(:game_mirror_mirror)
    
    @label = FactoryGirl.create(:label,game: @game)

    @member= FactoryGirl.create(:member, game:@game,game_admin: true)
    @user=@member.user
  end


  test "should get index" do
    get :index, {:game_id=>@game.id},{:user_id=>@user.id}
    assert_response :success
    assert_not_nil assigns(:labels)
  end

  test "should get new" do
    get :new, {:game_id=>@game.id},{:user_id=>@user.id}
    assert_response :success
  end

  test "should create label" do
    assert_difference('Label.count') do
      @label.name = @label.name + @label.name
      post :create, {:game_id=>@game.id,label: @label.attributes},{:user_id=>@user.id}
    end

    assert_redirected_to game_label_path(@game,assigns(:label))
  end

  test "should show label" do
    get :show, {id: @label.to_param,:game_id=>@game.id},{:user_id=>@user.id}
    assert_response :success
  end

  test "should get edit" do
    get :edit, {id: @label.to_param,:game_id=>@game.id},{:user_id=>@user.id}
    assert_response :success
  end

  test "should update label" do
    put :update, {id: @label.to_param,:game_id=>@game.id,skill: @label.attributes},{:user_id=>@user.id} 
    assert_redirected_to game_label_path(@game,assigns(:label))
  end

  test "should destroy label" do
    assert_difference('Label.count', -1) do
      delete :destroy, {id: @label.to_param,:game_id=>@game.id},{:user_id=>@user.id}
    end

    assert_redirected_to game_labels_path(@game)
  end
end
