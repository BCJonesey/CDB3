
class CharactersController < ApplicationController
  before_filter :require_logged_in_user
  before_filter :require_game
  before_filter :get_or_create_member, :only => [:new]
  
  # GET /characters
  # GET /characters.json
  def index
    @characters = []

    unless @member.nil?
      @characters = @member.characters
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
    @character = Character.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/new
  # GET /characters/new.json
  def new
    @character = Character.new

    @players = nil

    if game_admin?(@game)
      @players = User.all
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @character }
    end
  end

  # GET /characters/1/edit
  def edit
    @character = Character.find(params[:id])
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(params[:character])

    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = @logged_in_user
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
    @character = Character.find(params[:id])

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
    @character = Character.find(params[:id])
    @character.destroy

    respond_to do |format|
      format.html { redirect_to game_characters_url(@game) }
      format.json { head :ok }
    end
  end

  private

  def require_character_edit_authority

  end
end
