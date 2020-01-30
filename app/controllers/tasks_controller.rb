class TasksController < ApplicationController
  before_action :set_project_id, only: [:new, :show, :edit, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :checkAccess, only: [:new, :show, :edit, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if params.has_key?(:id) && params[:id] != ""
      @tasks = Task.where(project_id: params[:id])
      @id = params[:id]
      @project = Project.where(id: params[:id])
    else
      redirect_back fallback_location: root_path
    end
    
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @id = params[:id]
    @user_id = session[:user_id]
  end

  # GET /tasks/1/edit
  def edit
    @pid = params[:project_id]
    @uid = session[:user_id]
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:project_id, :user_id, :title)
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
