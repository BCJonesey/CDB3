class GamesController < ApplicationController
  before_action :require_login
  before_action :require_global_admin, :except => [:show]
  before_action :get_member, :except=>[:new, :create,:index]
  
  

  def index
    @games = Game.all
  end

  def show
    if current_user.game_admin?(@game)
      @members = @game.members
    end
    @use_highlighted = true
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(params.require(:game).permit(:name,:slug,:side_effects,:public))
    
    if @game.save
      redirect_to game_path(@game), :notice => "Game created: #{@game.name}"
    else
      redirect_to new_game_path, :alert => "That didn't work."
    end
  end

  def edit
    @game = Game.friendly.find(params[:id])
  end

  def update
    @game = Game.friendly.find(params[:id])
    @game.update_attributes(params.require(:game).permit(:name,:slug,:side_effects,:public))
    redirect_to game_path(@game), :notice => "Game updated: #{@game.name}"    
  end

  def destroy
    @game = Game.friendly.find(params[:id])
    if (params[:confirm] == "Yes")
      @game.destroy
      redirect_to games_path, :notice => "Game deleted: #{@game.name}"
    else
      redirect_to game_path(@game), :alert => "Must confirm game deletion"
    end
  end
  

end
