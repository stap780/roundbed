class PermclActionsController < ApplicationController
  load_and_authorize_resource
  before_action :set_permcl_action, only: [:show, :edit, :update, :destroy]

  # GET /permcl_actions
  # GET /permcl_actions.json
  def index
    @permcl_actions = PermclAction.all
  end

  # GET /permcl_actions/1
  # GET /permcl_actions/1.json
  def show
  end

  # GET /permcl_actions/new
  def new
    @permcl_action = PermclAction.new
  end

  # GET /permcl_actions/1/edit
  def edit
  end

  # POST /permcl_actions
  # POST /permcl_actions.json
  def create
    @permcl_action = PermclAction.new(permcl_action_params)

    respond_to do |format|
      if @permcl_action.save
        format.html { redirect_to @permcl_action, notice: 'Permcl action was successfully created.' }
        format.json { render :show, status: :created, location: @permcl_action }
      else
        format.html { render :new }
        format.json { render json: @permcl_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permcl_actions/1
  # PATCH/PUT /permcl_actions/1.json
  def update
    respond_to do |format|
      if @permcl_action.update(permcl_action_params)
        format.html { redirect_to @permcl_action, notice: 'Permcl action was successfully updated.' }
        format.json { render :show, status: :ok, location: @permcl_action }
      else
        format.html { render :edit }
        format.json { render json: @permcl_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permcl_actions/1
  # DELETE /permcl_actions/1.json
  def destroy
    @permcl_action.destroy
    respond_to do |format|
      format.html { redirect_to permcl_actions_url, notice: 'Permcl action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permcl_action
      @permcl_action = PermclAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permcl_action_params
      params.require(:permcl_action).permit(:title)
    end
end
