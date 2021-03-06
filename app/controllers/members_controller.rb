class MembersController < ApplicationController
  before_action :require_login
  before_action :require_game
  before_action :require_member, :except => [:new, :create]
  before_action :require_game_admin, :except => [:show, :new, :create]
  before_action :get_resource_and_match_game, :except => [:index, :new, :create]

  # GET /members
  # GET /members.json
  def index
    @members = @game.members

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    if require_member_match_or_admin(@member)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @member }
      end
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.find_by_game_id_and_user_id(@game.id, current_user.id)

    if @member
      redirect_to game_path(@game), :notice => "You are already a member."
      return
    end

    if @member.nil?
      @member = Member.new(:user_id => current_user.id, :game_id => @game.id)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit

  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new()
    @member.game = @game
    @member.user = current_user

    
    respond_to do |format|
      if @member.save
        format.html do 
          redirect_to @game, notice: 'Member was successfully created.'
        end
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update

    respond_to do |format|
      if @member.update_attributes(params.require(:member).permit(:game_admin))
        format.html { redirect_to [@game, @member], notice: 'Member was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to game_members_url(@game) }
      format.json { head :ok }
    end
  end
end
