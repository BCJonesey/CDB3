
class MainController < ApplicationController
  before_action :first_run_check
  
  def first_run_check
    if User.count < 1
      redirect_to new_user_path, 
        :notice => "This is a first run, please create an initial user account."
      return
    end
  end
  
  def index
    session[:request_path] = '/'
    @use_highlighted = true
    
    @games  = Game.all.find_all {|g| g.public? }
    @events = Event.all 
  end

  def login
  end

  def logout
    session[:user_id] = nil
    redirect_to '/', :notice => "Logged out"
  end
end
