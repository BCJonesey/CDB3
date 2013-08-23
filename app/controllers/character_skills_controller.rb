class CharacterSkillsController < ApplicationController
  before_filter :require_logged_in_user
  before_filter :require_game
  before_filter :get_member
  before_filter :get_resource_and_match_game, :except => [ :create]
  
  def create
    @character_skill = CharacterSkill.new(params[:character_skill])
    respond_to do |format|
      if @character_skill.save
        format.json { render json: @character_skill, status: :created, location: @character_skill }
      else
        format.json { render json: @character_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @character_skill = CharacterSkill.find(params[:id])
    respond_to do |format|
      if @character_skill.update_attributes(params[:character_skill])
        format.json { head :ok }
      else
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @character_skill = CharacterSkill.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @character_skill }
    end
  end

end
