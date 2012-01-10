class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    
    if(User.count < 1)
      @user.global_admin = true
      @user.save
      redirect_to root_path, :notice => "You have been added as a global admin."
      return
    elsif(User.find_all_by_email(params[:user][:email].downcase).count>0)
      redirect_to request.referer, :alert => "A user with that email already exists"
      return
    end
    
    if(@user.save)
     redirect_to request.referer, :notice => "User has been created."
    else
     redirect_to request.referer, :alert => "Failed to create user."
    end
    
  end
  
  def update
    @user = User.find(params[:id])
    if(@user.email != params[:user][:email].downcase && User.find_all_by_email(params[:user][:email].downcase).count>0)
      redirect_to request.referer, :alert => "A user with that email already exists"
      return
    else
        @user.update_attributes(params[:user])
	redirect_to request.referer, :notice => "User updated: #{@user.name}"  
    end
  end

  
  def index
    @users = User.all;
  end
  
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end

end
