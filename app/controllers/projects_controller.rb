class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :destroy]
  before_action :authorized, only: [:index, :show, :edit, :update, :destroy]
  #before_action :current_user_required, only: [ :edit, :update, :destroy ]
  before_action :checkAccess, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index()
    @projects = Project.where(:id => Team.select(:project_id).where(user_id: session[:user_id] ).map(&:project_id))
    
    @users = User.all
  end

  def dashboard()
    @projects = Project.where(:id => Team.select(:project_id).where(user_id: session[:user_id] ).map(&:project_id)).order(created_at: :desc).limit(5)
    @users = User.where(id: session[:user_id])
    @shared = Team.where(user_id: session[:user_id])
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    #@attachment = Project.find(15)
    #@attachment.file.attach(params[:files])
    @comment = Comment.new
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user_id = session[:user_id]

    respond_to do |format|
      if @project.save
        @team = Team.new
        @team.project_id = @project.id
        @team.user_id = session[:user_id]
        @team.read_access = 1
        @team.write_access = 1
        @team.update_access = 1
        @team.delete_access = 1
        @team.save
        return redirect_to projects_path
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroyattachment
    redirect_to project_path
  end

  def upload
      @project = Project.find(params[:projectId])
      @project.file.attach(params[:files])
      if @project.save
        redirect_back fallback_location: root_path
      end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        return redirect_to projects_path
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, file: [])
    end

    def team_params
      params.require(:team).permit(:project_id, :user_id, :read_access, :write_access, :update_access, :delete_access)
    end

  private 
    def current_user_required
      unless current_user == @project.user
        flash[:error] = 'Sorry you are not permitted to perform such action! '
        redirect_back fallback_location: root_path
      end
    end

    def checkAccess
      @participants = Team.where(project_id: @project)
      @user = @participants.select { |i| i.user_id == session[:user_id] }       
      @access = Hash.new
      @access['show'] =  @user[0].read_access
      @access['new'] = @user[0].write_access
      @access['edit'] =  @user[0].update_access
      @access['delete'] =  @user[0].delete_access
      unless @access[action_name] == 1 || current_user == @project.user
        flash[:access_error] = "you dont have access to perform this action."
        redirect_back fallback_location: root_url
      end
    end

    
end
