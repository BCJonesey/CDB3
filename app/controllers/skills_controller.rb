class SkillsController < ApplicationController
  before_filter :require_login
  before_filter :require_game
  before_filter :get_member
  before_filter :require_game_admin, :except => [:index,:show]
  before_filter :get_resource_and_match_game, :except => [:index, :new, :create]
  
  # GET /skills
  # GET /skills.json
  def index
    @skills = @game.skills
    respond_to do |format|
      format.html { require_game_admin }
      format.json { render json: @skills.to_json(:include=>:tags)  }
    end
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
    @skillTag = SkillTag.new({:skill_id => @skill.id})
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @skill}
    end
  end

  # GET /skills/new
  # GET /skills/new.json
  def new
    @skill = Skill.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skill }
    end
  end

  # GET /skills/1/edit
  def edit
   
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(params[:skill])
    @skill.game = @game
    respond_to do |format|
      if @skill.save
        format.html { redirect_to [@game,@skill], notice: 'Skill was successfully created.' }
        format.json { render json: @skill, status: :created, location: @skill }
      else
        format.html { render action: "new" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /skills/1
  # PUT /skills/1.json
  def update


    respond_to do |format|
      if @skill.update_attributes(params[:skill])
        format.html { redirect_to [@game,@skill], notice: 'Skill was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy

    @skill.destroy

    respond_to do |format|
      format.html { redirect_to game_skills_url(@game) }
      format.json { head :ok }
    end
  end
  

  # PUT /skills/1
  # PUT /skills/1.json
  def add_tag
    respond_to do |format|
      @skillTag = SkillTag.new(params[:skill_tag])
      if @skillTag.save
        format.html { redirect_to [@game,@skill], notice: 'Skill was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "show" }
        format.json { render json: @skillTag.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT /skills/1
  # PUT /skills/1.json
  def remove_tag
    SkillTag.find(params[:skill_tag_id]).destroy

    respond_to do |format|
      format.html { redirect_to [@game,@skill]}
      format.json { head :ok }
    end
  end
  
    
end
