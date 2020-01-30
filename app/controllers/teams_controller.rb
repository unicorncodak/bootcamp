class TeamsController < ApplicationController
  before_action :set_project_id, only: [:new, :show, :edit, :destroy]
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :checkAccess, only: [:new, :show, :edit, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    if params.has_key?(:id) && params[:id] != ""
      @teams = Team.where(project_id: params[:id])
      @id = params[:id]
      @project= Project.where(id: params[:id])
    else
      redirect_back fallback_location: root_path
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    if params.has_key?(:id) && params[:id] != ""
      @team = Team.new
      @getID = params[:id]
      filter_id = Team.where(project_id: params[:id]).pluck(:user_id)
      @users = User.where.not(id: filter_id).pluck(:username, :id).to_a.unshift(["Select User", ""])
      @project = Project.find(params[:id])
    else
      redirect_to projects_path
    end
  end

  # GET /teams/1/edit
  def edit
    @getID = params[:id]
    @users = User.where(id: params[:user_id]).pluck(:username, :id)
    @project = Project.find(params[:project_id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    
    respond_to do |format|
      if @team.save
        format.html { redirect_to teams_path(:id => team_params[:project_id]), notice: 'User was successfully added.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to teams_path(:id => team_params[:project_id]), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    def set_project_id
      if action_name == 'edit'
        @projectId = params[:project_id]
      elsif action_name == 'new'
        @projectId = params[:id]
      elsif action_name == 'destroy'
        @projectId = params[:project_id]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:project_id, :user_id, :read_access, :write_access, :update_access, :delete_access)
    end

    def checkAccess
      @participants = Team.where(project_id: @projectId)
      @user = @participants.select { |i| i.user_id == session[:user_id] }       
      @access = Hash.new
      @access['show'] =  @user[0].read_access
      @access['new'] = @user[0].write_access
      @access['edit'] =  @user[0].update_access
      @access['delete'] =  @user[0].delete_access
      unless @access[action_name] == 1
        flash[:access_error] = "you dont have access to perform this action."
        redirect_back fallback_location: root_url
      end
    end
end
