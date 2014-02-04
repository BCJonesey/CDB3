class CharacterSkillsController < ApplicationController
  before_filter :require_login
  before_filter :require_game
  before_filter :get_member
  before_filter :get_character
  #before_filter :require_game_admin, :except => [:index,:show]
  #before_filter :get_resource_and_match_game, :except => [:index, :new, :create]
  
  
  # GET /tags
  # GET /tags.json
  def index
    @skills = Skill.all
    @skills_hash = @skills.as_json(:include => [:tags])
    @skills_hash.map! do |x| 
      x["rank"] = @character.skill_rank(x["id"]) 
      x
    end
    render json: @skills_hash
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @skill=Skill.find(params[:id])
    @skill_hash = @skill.as_json(:include => [:tags])
    @skill_hash["rank"] = @character.skill_rank(@skill_hash["id"])
    render json: @skill_hash
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    if @character.set_skill_rank(params[:id],params[:skill][:rank])
      head :ok
    else
      render text: "error", status: :unprocessable_entity
    end
  end

  def get_character
    @character = Character.find(params["character_id"])
  end

end
