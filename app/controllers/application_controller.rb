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
end
