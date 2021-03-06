class CharacterSkillsController < ApplicationController
  #before_action :require_login
  before_action :require_game
  #before_action :get_member
  before_action :get_character
  #before_action :require_game_admin, :except => [:index,:show]
  #before_action :get_resource_and_match_game, :except => [:index, :new, :create]


  # GET /tags
  # GET /tags.json
  def index
    render json: skills_hash
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
    if @character.set_skill_rank(params[:id],params[:character_skill][:rank])
      render json: skills_hash
    else
      render text: "error", status: :unprocessable_entity
    end
  end

  def get_character
    @character = Character.find(params["character_id"])
  end


  private
  def skills_hash
    skills = @game.skills.includes(skill_tags: :tag)
    
    
    
    skills_hash = skills.as_json(include: {skill_tags:{ include: :tag,only:[:gives]}})
    rank_hash = Hash.new(0)
    @character.get_or_create_version.character_skills.each do |x|
      rank_hash[x.skill_id] = x.rank
    end

    
    {
      skills: Hash[skills_hash.collect { |skill| [skill["id"], skill] }],
      skillRanks: rank_hash
    }

    
  end

end
