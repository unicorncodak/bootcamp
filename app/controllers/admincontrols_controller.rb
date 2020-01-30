class AdmincontrolsController < ApplicationController
  #before_action :set_admincontrol, only: [:show, :edit, :update, :destroy]

  # GET /admincontrols
  # GET /admincontrols.json
  def index
    @admincontrols = Admincontrol.all
  end

  # GET /admincontrols/1
  # GET /admincontrols/1.json
  def show
  end

  # GET /admincontrols/new
  def new
    @admincontrol = Admincontrol.new
  end

  # GET /admincontrols/1/edit
  def edit
  end

  # POST /admincontrols
  # POST /admincontrols.json
  def create
    @admincontrol = Admincontrol.new(admincontrol_params)

    respond_to do |format|
      if @admincontrol.save
        format.html { redirect_to @admincontrol, notice: 'Admincontrol was successfully created.' }
        format.json { render :show, status: :created, location: @admincontrol }
      else
        format.html { render :new }
        format.json { render json: @admincontrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admincontrols/1
  # PATCH/PUT /admincontrols/1.json
  def update
    respond_to do |format|
      if @admincontrol.update(admincontrol_params)
        format.html { redirect_to @admincontrol, notice: 'Admincontrol was successfully updated.' }
        format.json { render :show, status: :ok, location: @admincontrol }
      else
        format.html { render :edit }
        format.json { render json: @admincontrol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admincontrols/1
  # DELETE /admincontrols/1.json
  def destroy
    @admincontrol.destroy
    respond_to do |format|
      format.html { redirect_to admincontrols_url, notice: 'Admincontrol was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admincontrol
      @admincontrol = Admincontrol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admincontrol_params
      params.fetch(:admincontrol, {})
    end
end
