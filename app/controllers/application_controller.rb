class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def get_logged_in_user
    if session[:user_id].nil?
      @user = nil
    else
      @user = User.find(session[:user_id])
    end
  end

  def require_logged_in_user
    get_logged_in_user

    if @user.nil?
      redirect_to '/', :alert => "Access denied: requires logged in user"
    end
  end

  def require_global_admin
    get_logged_in_user

    if @user.nil? or !@user.global_admin?
      redirect_to '/', :alert => "Access denied: requires global admin"
    end
  end

  def get_current_game
    if params[:game_id].nil?
      @game = nil
    else
      @game = Game.find_by_id(params[:game_id])
    end
  end

  def require_game
    get_current_game

    if @game.nil?
      redirect_to '/', :alert => "No such game"
    end
  end
  
  def get_resource_and_match_game  
    current_item = params[:controller].to_s.classify.constantize.find(params[:id])
    instance_variable_set("@" + params[:controller].to_s.classify.downcase,current_item)
    if(current_item.nil? || current_item.game != @game)
      redirect_to '/', :alert => "No such game"
    end
  end
  

  def require_game_member
    get_logged_in_user
    get_current_game

    if @game.nil? or @user.nil?
      redirect_to '/', :alert => "No such game"
      return
    end

    @member = Member.find_or_create_by_user_id_and_game_id(@user.id, @game.id)

    if @member.nil?
      redirect_to '/', :alert => "Requires game member"
    end
  end

  def require_game_admin
    get_logged_in_user
    get_current_game

    if @game.nil?
      redirect_to '/', :alert => "No such game"
      return
    end

    if @user.nil?
      redirect_to '/', :alert => "Not logged in"
      return
    end

    unless @user.global_admin?
      member = Member.find_by_user_id_and_game_id(@user, @game)

      if member.nil? || !member.game_admin?
        redirect_to '/', :alert => "Access denied: requires game admin"
      end
    end
  end
end
