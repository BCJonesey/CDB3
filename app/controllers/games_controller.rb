class GamesController < ApplicationController
  before_filter :require_logged_in_user
  before_filter :require_global_admin, :except => [:index, :show]

  def index
    @games = Game.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
