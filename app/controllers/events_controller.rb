class EventsController < ApplicationController
  before_action :require_login
  before_action :require_game
  before_action :get_member
  before_action :require_game_admin, :except => [:index,:show,:registration_buttons]
  before_action :get_resource_and_match_game, :except => [:index, :new, :create]

  # GET /events
  # GET /events.json
  def index
    @events = @game.events

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit

  end
  
  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params.require(:event).permit(:start_date, :end_date, :site, :notes, :player_cap))
    @event.game = @game
    respond_to do |format|
      if @event.save
        format.html { redirect_to [@game, @event], notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update

    respond_to do |format|
      if @event.update_attributes(params.require(:event).permit(:start_date, :end_date, :site, :notes, :player_cap))
        format.html { redirect_to [@game, @event], notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to game_events_url(@game) }
      format.json { head :ok }
    end
  end
  

  def registration_buttons
    render :partial => "registration_buttons", :locals => { :event => @event }
  end
  
end
