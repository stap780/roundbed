class AsabsController < ApplicationController
	load_and_authorize_resource
  before_action :set_asab, only: [:show, :edit, :update, :destroy]

  # GET /asabs
  # GET /asabs.json
  def index
#     @asabs = Asab.all
	@search = Asab.ransack(params[:q]) #используется application_controller и там в before filter :set_search
	@search.sorts = 'id asc' if @search.sorts.empty? # сортировка таблицы по id по умолчанию 
	@asabs = @search.result.paginate(page: params[:page], per_page: 100)
  end

  # GET /asabs/1
  # GET /asabs/1.json
  def show
  end

  # GET /asabs/new
  def new
    @asab = Asab.new
  end

  # GET /asabs/1/edit
  def edit
  end

  # POST /asabs
  # POST /asabs.json
  def create
    @asab = Asab.new(asab_params)

    respond_to do |format|
      if @asab.save
        format.html { redirect_to @asab, notice: 'Asab was successfully created.' }
        format.json { render :show, status: :created, location: @asab }
      else
        format.html { render :new }
        format.json { render json: @asab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asabs/1
  # PATCH/PUT /asabs/1.json
  def update
    respond_to do |format|
      if @asab.update(asab_params)
        format.html { redirect_to @asab, notice: 'Asab was successfully updated.' }
        format.json { render :show, status: :ok, location: @asab }
      else
        format.html { render :edit }
        format.json { render json: @asab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asabs/1
  # DELETE /asabs/1.json
  def destroy
    @asab.destroy
    respond_to do |format|
      format.html { redirect_to asabs_url, notice: 'Asab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def download
	Asab.delay.download
	flash[:notice] = 'Задача запущена'
	redirect_to asabs_path	
  end
  
	def insales
		Asab.delay.insales_to_csv
		flash[:notice] = 'Задача запущена'
		redirect_to asabs_path
	end
	
  def import
    Asab.import(params[:file])
	redirect_to asabs_path	
  end
  
	def delete_selected
		@asabs = Asab.find(params[:ids])
		@asabs.each do |item|
		    item.destroy
		end
		respond_to do |format|
		  format.html { redirect_to items_url, notice: 'Товары удалёны' }
		  format.json { render json: {:status => "ok", :message => "Товары удалёны"} }
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asab
      @asab = Asab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asab_params
      params.require(:asab).permit(:aid, :sku, :title, :sdesc, :desc, :cprice, :price, :qt, :image, :sostav)
    end
end
