class TagsController < ApplicationController
  before_action :require_login
  before_action :require_game
  before_action :get_member
  before_action :require_game_admin, :except => [:index,:show]
  before_action :get_resource_and_match_game, :except => [:index, :new, :create]
  
  
  # GET /tags
  # GET /tags.json
  def index
    @tags = @game.tags

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = @game.tags.create(params.require(:tag).permit(:name))
    respond_to do |format|
      if @tag.save
        format.html { redirect_to [@game,@tag], notice: 'Tag was successfully created.' }
        format.json { render json: @tag, status: :created, location:[@game,@tag] }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params.require(:tag).permit(:name))
        format.html { redirect_to [@game,@tag], notice: 'Tag was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to game_tags_url(@game) }
      format.json { head :ok }
    end
  end
end
