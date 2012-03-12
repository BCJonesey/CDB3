class MembersController < ApplicationController
  before_filter :require_logged_in_user
  before_filter :require_game
  before_filter :require_game_admin, :except => [:index, :show, :new, :create]
  before_filter :get_resource_and_match_game, :except => [:index, :new, :create]

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
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.find_by_game_id_and_user_id(@game.id, @logged_in_user.id)

    if @member and !@member.game_admin?
      redirect_to game_path(@game), :notice => "You are already a member."
      return
    end

    if @member.nil?
      @member = Member.new(:user_id => @logged_in_user.id, :game_id => @game.id)
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
    @member = Member.new(params[:member])
    @member.game = @game
    
    unless @logged_in_user.game_admin?(@game)
      @member.user = @logged_in_user
    end
    
    respond_to do |format|
      if @member.save
        format.html do 
          redirect_to [@game, @member], notice: 'Member was successfully created.'
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
      if @member.update_attributes(params[:member])
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
