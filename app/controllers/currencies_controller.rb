class CurrenciesController < ApplicationController

  before_action :require_game
  before_action :get_resource_and_match_game, :except => [:index, :new, :create]
  before_action :get_member
  before_action :require_game_admin
  
  # GET /currencies
  # GET /currencies.json
  def index
    @currencies = @game.currencies

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @currencies }
    end
  end

  # GET /currencies/1
  # GET /currencies/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @currency }
    end
  end

  # GET /currencies/new
  # GET /currencies/new.json
  def new
    @currency = Currency.new
    @currency.game_id = @game.id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @currency }
    end
  end

  # GET /currencies/1/edit
  def edit
    
  end

  # POST /currencies
  # POST /currencies.json
  def create
    @currency = @game.currencies.build( params.require(:currency).permit(:starting_amount, :cap))

    
    respond_to do |format|
      if @currency.save
        format.html { redirect_to [@game, @currency], notice: 'Currency was successfully created.' }
        format.json { render json: @currency, status: :created, location: @currency }
      else
        format.html { render action: "new" }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /currencies/1
  # PUT /currencies/1.json
  def update

    respond_to do |format|
      if @currency.update_attributes( params.require(:currency).permit(:starting_amount, :cap))
        format.html { redirect_to [@game, @currency], notice: 'Currency was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @currency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currencies/1
  # DELETE /currencies/1.json
  def destroy
    @currency.destroy

    respond_to do |format|
      format.html { redirect_to game_currencies_url }
      format.json { head :ok }
    end
  end
end
