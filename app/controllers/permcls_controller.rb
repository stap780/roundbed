class PermclsController < ApplicationController
  load_and_authorize_resource
  before_action :set_permcl, only: [:show, :edit, :update, :destroy]

  # GET /permcls
  # GET /permcls.json
  def index
    @permcls = Permcl.all
  end

  # GET /permcls/1
  # GET /permcls/1.json
  def show
  end

  # GET /permcls/new
  def new
    @permcl = Permcl.new
  end

  # GET /permcls/1/edit
  def edit
  end

  # POST /permcls
  # POST /permcls.json
  def create
    @permcl = Permcl.new(permcl_params)

    respond_to do |format|
      if @permcl.save
        format.html { redirect_to @permcl, notice: 'Permcl was successfully created.' }
        format.json { render :show, status: :created, location: @permcl }
      else
        format.html { render :new }
        format.json { render json: @permcl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permcls/1
  # PATCH/PUT /permcls/1.json
  def update
    respond_to do |format|
      if @permcl.update(permcl_params)
        format.html { redirect_to @permcl, notice: 'Permcl was successfully updated.' }
        format.json { render :show, status: :ok, location: @permcl }
      else
        format.html { render :edit }
        format.json { render json: @permcl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permcls/1
  # DELETE /permcls/1.json
  def destroy
    @permcl.destroy
    respond_to do |format|
      format.html { redirect_to permcls_url, notice: 'Permcl was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permcl
      @permcl = Permcl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permcl_params
      params.require(:permcl).permit(:systitle, :title)
    end
end
