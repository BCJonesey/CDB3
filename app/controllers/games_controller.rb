class GamesController < ApplicationController
  before_filter :require_logged_in_user, :except => [:login]
  before_filter :require_global_admin, :except => [:login, :index, :show]

  def login
    @game = Game.find(params[:game_id])
  end

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(params[:game])
    redirect_to game_path(@game), :notice => "Game created: #{@game.name}"
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(params[:game])
    redirect_to game_path(@game), :notice => "Game updated: #{@game.name}"    
  end

  def destroy
    @game = Game.find(params[:id])
    if (params[:confirm] == "Yes")
      @game.destroy
      redirect_to games_path, :notice => "Game deleted: #{@game.name}"
    else
      redirect_to game_path(@game), :alert => "Must confirm game deletion"
    end
  end

end
