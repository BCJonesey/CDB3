class UsersController < ApplicationController
  before_filter :require_global_admin, :except => [:new,:create,:edit,:update]
  before_filter :require_global_admin_unless_owned, :only => [:edit,:update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params.require(:user).permit(:name, :password, :email))
    if(User.count < 1)
      @user.global_admin = true
    end
    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver

        format.html do
          redirect_to login_path,
            :notice => 'User was successfully created.'
        end
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    params["user"].delete("password") if params["user"]["password"] == ""
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params.require(:user).permit(:name, :password, :email))
        format.html { redirect_to root_path, notice: 'User was successfully updated.' } if @user.id == current_user.id
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  def require_global_admin_unless_owned
    @user = User.find(params[:id])
    require_global_admin unless @user.id == current_user.id
  end
end
