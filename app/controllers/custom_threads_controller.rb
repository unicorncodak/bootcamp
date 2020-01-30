class CustomThreadsController < ApplicationController
  before_action :set_project_id, only: [:new, :show, :edit, :destroy]
  before_action :set_custom_thread, only: [:show, :edit, :update, :destroy]
  before_action :checkAccess, only: [:new, :show, :edit, :update, :destroy]

  # GET /custom_threads
  # GET /custom_threads.json
  def index
    @custom_threads = CustomThread.all
  end

  # GET /custom_threads/1
  # GET /custom_threads/1.json
  def show
  end

  # GET /custom_threads/new
  def new
    if params.has_key?(:id) && params[:id] != ""
      @custom_thread = CustomThread.new
      @getID = params[:id]
      @project = Project.find(params[:id])
    else
      redirect_to projects_path
    end
    
  end
  # GET /custom_threads/1/edit
  def edit
    @getID = params[:id]
  end

  # POST /custom_threads
  # POST /custom_threads.json
  def create
    @project = Project.find(params[:custom_thread][:project_id])
    @custom_thread = @project.CustomThreads.build(custom_thread_params)

    respond_to do |format|
      if @custom_thread.save
        format.html { redirect_to new_custom_thread_path(:id => params[:custom_thread][:project_id]), notice: 'Thread was successfully created.' }
        format.json { render :show, status: :created, location: @custom_thread }
      else
        format.html { render :new }
        format.json { render json: @custom_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_threads/1
  # PATCH/PUT /custom_threads/1.json
  def update
    respond_to do |format|
      if @custom_thread.update(custom_thread_params)
        format.html { redirect_to edit_custom_thread_path(params[:id]), notice: 'Custom thread was successfully updated.' }
        format.json { render :show, status: :ok, location: @custom_thread }
      else
        format.html { render :edit }
        format.json { render json: @custom_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_threads/1
  # DELETE /custom_threads/1.json
  def destroy
    @custom_thread.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Thread was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_thread
      @custom_thread = CustomThread.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custom_thread_params
      params.require(:custom_thread).permit(:title, :project_id)
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
