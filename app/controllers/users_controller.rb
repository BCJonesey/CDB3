class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(params[:user])
    if(User.count == 1)
      redirect_to(root_path)
      return
    end
    redirect_to(request.referer)
  end

end
