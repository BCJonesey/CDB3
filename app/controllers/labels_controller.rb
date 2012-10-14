class LabelsController < ApplicationController
  before_filter :require_logged_in_user
  before_filter :require_game
  before_filter :get_resource_and_match_game, :except => [:index, :new, :create]
  
  
  # GET /labels
  # GET /labels.json
  def index
    @labels = Label.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @labels }
    end
  end

  # GET /labels/1
  # GET /labels/1.json
  def show
    @label = Label.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @label }
    end
  end

  # GET /labels/new
  # GET /labels/new.json
  def new
    @label = Label.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @label }
    end
  end

  # GET /labels/1/edit
  def edit
    @label = Label.find(params[:id])
  end

  # POST /labels
  # POST /labels.json
  def create
    @label = Label.new(params[:label])
    @label.game =@game
    respond_to do |format|
      if @label.save
        format.html { redirect_to [@game,@label], notice: 'Label was successfully created.' }
        format.json { render json: @label, status: :created, location:[@game,@label] }
      else
        format.html { render action: "new" }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /labels/1
  # PUT /labels/1.json
  def update
    @label = Label.find(params[:id])

    respond_to do |format|
      if @label.update_attributes(params[:label])
        format.html { redirect_to [@game,@label], notice: 'Label was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labels/1
  # DELETE /labels/1.json
  def destroy
    @label = Label.find(params[:id])
    @label.destroy

    respond_to do |format|
      format.html { redirect_to game_labels_url(@game) }
      format.json { head :ok }
    end
  end
end
