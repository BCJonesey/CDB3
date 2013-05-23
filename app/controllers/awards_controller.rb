class AwardsController < ApplicationController
  before_filter :require_logged_in_user
  before_filter :require_game
  before_filter :get_member
  before_filter :get_resource_and_match_game, :except => [:index, :new, :create,:request_award]
  before_filter :require_game_admin,:except => [:index,:request]
  
  # GET /awards
  # GET /awards.json
  def index
    @award = Award.new

    @pending_awards = []
    if(game_admin?(@game))
      @pending_awards = @game.awards.pending
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @awards }
    end
  end

  # GET /awards/1
  # GET /awards/1.json
  def show
    @award = Award.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @award }
    end
  end

  # GET /awards/new
  # GET /awards/new.json
  def new
    @award = Award.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @award }
    end
  end

  # GET /awards/1/edit
  def edit
    @award = Award.find(params[:id])
  end

  # POST /awards
  # POST /awards.json
  def create
    @award = Award.new(params[:award])
    respond_to do |format|
      if @award.save
        format.html { redirect_to [@game,@award], notice: 'Award was successfully created.' }
        format.json { render json: @award, status: :created, location: @award }
      else
        format.html { render action: "new" }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /awards/1
  # PUT /awards/1.json
  def update
    @award = Award.find(params[:id])

    respond_to do |format|
      if @award.update_attributes(params[:award])
        format.html { redirect_to [@game,@award], notice: 'Award was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.json
  def destroy
    @award = Award.find(params[:id])
    @award.destroy

    respond_to do |format|
      format.html { redirect_to game_awards_url(@game) }
      format.json { head :ok }
    end
  end
  
  def approve
    @award.approved_by = @member
    @award.save
    respond_to do |format|
      format.html { redirect_to :back}
      format.json { head :ok }
    end
  end
  
  def assign
    @award.character_id = params[:character_id]
    respond_to do |format|
      if @award.save
        format.html { redirect_to action: "index", notice: 'Award was successfully assigned.' }
        format.json { head :ok }
      else
        format.html { redirect_to action: "index", error: 'Could not assign.' }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def request_award
    @award = Award.new
    @award.member_id = @member.id
    @award.created_by_id = @member.id
    @award.amount = params[:award][:amount]
    @award.currency_id = params[:award][:currency_id]
    @award.comment = params[:award][:comment]
    respond_to do |format|
      if @award.save
        format.html { redirect_to action: "index", notice: 'Award was successfully requested.' }
        format.json { render json: @award, status: :created, location: @award }
      else
        format.html { render action: "index" }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end
  

end
