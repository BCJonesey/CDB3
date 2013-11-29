
class CharactersController < ApplicationController
  before_filter :require_login
  before_filter :require_game
  before_filter :get_member
  before_filter :require_game_admin, :only => [:destroy]
  before_filter :get_resource_and_match_game, :except => [:index, :new, :create]
  
  # GET /characters
  # GET /characters.json
  def index
    @characters = []

    unless @current_member.nil?
      @characters = @current_member.characters
    end

    @all_characters = []
    
    if game_admin?(@game) or global_admin?
      @all_characters = @game.characters
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @characters }
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @character.get_or_create_version
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character.to_json(:include => {:character_version => {:include=>:character_skills}} )}
    end
  end

  # GET /characters/new
  # GET /characters/new.json
  def new
    @character = Character.new

    @users = nil

    if game_admin?(@game)
      @users = User.all
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/1/edit
  def edit
    
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(params[:character])

    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end

    @member = Member.find_or_create_by_user_id_and_game_id(@user.id, @game.id)
    @character.member_id = @member.id


    respond_to do |format|
      if @character.save
        format.html { redirect_to [@game, @character], notice: 'Character was successfully created.' }
        format.json { render json: @character, status: :created, location: @character }
      else
        format.html { render action: "new" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /characters/1
  # PUT /characters/1.json
  def update

    respond_to do |format|
      if @character.update_attributes(params[:character])
        format.html { redirect_to [@game, @character], notice: 'Character was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character.destroy

    respond_to do |format|
      format.html { redirect_to game_characters_url(@game) }
      format.json { head :ok }
    end
  end
  
  
  def character_version
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @character.get_or_create_version.to_json(:include=>:character_skills)  }
    end
  end

end
