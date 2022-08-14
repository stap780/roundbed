class InfasController < ApplicationController
	load_and_authorize_resource
  before_action :set_infa, only: [:show, :edit, :update, :destroy]

  # GET /infas
  # GET /infas.json
  def index
#     @infas = Infa.all
	@search = Infa.ransack(params[:q]) 
	@search.sorts = 'id asc' if @search.sorts.empty? # сортировка таблицы по id по умолчанию 
	@infas = @search.result.paginate(page: params[:page], per_page: 100)
  end

  # GET /infas/1
  # GET /infas/1.json
  def show
  end

  # GET /infas/new
  def new
    @infa = Infa.new
  end

  # GET /infas/1/edit
  def edit
  end

  # POST /infas
  # POST /infas.json
  def create
    @infa = Infa.new(infa_params)

    respond_to do |format|
      if @infa.save
        format.html { redirect_to @infa, notice: 'Infa was successfully created.' }
        format.json { render :show, status: :created, location: @infa }
      else
        format.html { render :new }
        format.json { render json: @infa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infas/1
  # PATCH/PUT /infas/1.json
  def update
    respond_to do |format|
      if @infa.update(infa_params)
        format.html { redirect_to @infa, notice: 'Infa was successfully updated.' }
        format.json { render :show, status: :ok, location: @infa }
      else
        format.html { render :edit }
        format.json { render json: @infa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infas/1
  # DELETE /infas/1.json
  def destroy
    @infa.destroy
    respond_to do |format|
      format.html { redirect_to infas_url, notice: 'Infa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def delete_selected
    @infas = Infa.find(params[:ids])
	@infas.each do |product|
	    product.destroy
	end
	respond_to do |format|
	  format.html { redirect_to laetes_path, notice: 'Товары удалёны' }
	  format.json { render json: {:status => "ok", :message => "Товары удалёны"} }
	  format.js { render :nothing => true }
	end
  end
  
  def download
	Infa.delay.download
	flash[:notice] = 'Задача запущена'
	redirect_to infas_path	
  end
  
	def insales
		Infa.delay.insales_to_csv
		flash[:notice] = 'Задача запущена'
		redirect_to infas_path
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_infa
      @infa = Infa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def infa_params
      params.require(:infa).permit(:fid, :sku, :barcode, :title, :desc, :feature, :costprice, :price, :qt, :image, :vendor, :model, :i_param, :cat)
    end
end
