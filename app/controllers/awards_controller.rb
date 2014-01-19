class AwardsController < ApplicationController
  before_filter :require_login
  before_filter :require_game
  before_filter :get_member
  before_filter :get_resource_and_match_game, :except => [:index, :new, :create,:request_award]
  before_filter :require_game_admin,:except => [:index,:request_award,:assign]
  
  # GET /awards
  # GET /awards.json
  def index

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
    @award = Award.new
    @award.created_by_id = @current_member.id
    set_vars
    respond_to do |format|
      if @award.save
        format.html { redirect_to :back, notice: 'Award was successfully created.' }
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
    set_vars
    respond_to do |format|
      if @award.save
        format.html { redirect_to :back, notice: 'Award was successfully updated.' }
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
      format.html { redirect_to(:back, :notice => 'Award was successfully deleted.')  }
      format.json { head :ok }
    end
  end

  private 

  def set_vars
    @award.amount = params[:award][:amount] if params[:award].has_key?(:amount)
    @award.currency_id = params[:award][:currency_id] if params[:award].has_key?(:currency_id)
    @award.comment = params[:award][:comment] if params[:award].has_key?(:comment)
    @award.member_id = params[:award][:member_id] if params[:award].has_key?(:member_id)
    if @current_member.is_admin
      @award.approved_by = @current_member if params[:award].has_key?(:approve)
    end
  end
  

end
