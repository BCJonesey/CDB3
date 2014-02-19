class ApplicationController < ActionController::Base
  protect_from_forgery
  protected

  def get_logged_in_user
    if session[:user_id].nil?
      current_user = nil
    else
      current_user = User.find(session[:user_id])
    end
  end

  def not_authenticated
    redirect_to login_path, :alert => "You must log in to access that page."
  end

  def global_admin?
    get_logged_in_user
    !current_user.nil? ? current_user.global_admin?: false
  end

  def require_global_admin
    unless global_admin?
      redirect_to '/', :alert => "Access denied: requires global admin"
    end
  end

  def get_current_game
    if(params[:controller].to_s.classify.downcase == 'game')
      @game = Game.find(params[:id])
    elsif params[:game_id].nil?
      @game = nil
    else
      @game = Game.find(params[:game_id])
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
      redirect_to '/', :alert => "No such "+params[:controller].to_s.classify
    end
  end
  
  def game_admin?(game)
    get_logged_in_user

    if game.nil? or current_user.nil? 
      return false
    end

    if global_admin?
      return true
    else
      member = Member.find_by_user_id_and_game_id(current_user.id, @game.id)

      if member.nil? || !member.game_admin?
        return false
      else
        return true
      end
    end

  end

  def require_game_admin
    get_current_game

    unless game_admin?(@game)
      redirect_to @game, :alert => "Access denied: requires game admin"
    end
  end
  
  def require_member
    get_member
    unless !@current_member.nil?
      redirect_to @game, :alert => "You must be a member of this game to visit that page"
    end
  end

  def get_or_create_member
    get_logged_in_user
    get_current_game

    @current_member = Member.find_or_create_by_user_id_and_game_id(current_user.id, @game.id)
  end
  
  def get_member
    get_logged_in_user
    get_current_game

    @current_member = Member.find_by_user_id_and_game_id(current_user.id, @game.id)
  end
end
