class CleosController < ApplicationController
	load_and_authorize_resource
	before_action :set_cleo, only: [:show, :edit, :update, :destroy]

  # GET /cleos
  # GET /cleos.json
  def index
#     @cleos = Cleo.all
	@search = Cleo.ransack(params[:q])
	@search.sorts = 'id asc' if @search.sorts.empty? # сортировка таблицы по id по умолчанию 
	@cleos = @search.result.paginate(page: params[:page], per_page: 100)
  end

  # GET /cleos/1
  # GET /cleos/1.json
  def show
  end

  # GET /cleos/new
  def new
    @cleo = Cleo.new
  end

  # GET /cleos/1/edit
  def edit
  end

  # POST /cleos
  # POST /cleos.json
  def create
    @cleo = Cleo.new(cleo_params)

    respond_to do |format|
      if @cleo.save
        format.html { redirect_to @cleo, notice: 'Cleo was successfully created.' }
        format.json { render :show, status: :created, location: @cleo }
      else
        format.html { render :new }
        format.json { render json: @cleo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cleos/1
  # PATCH/PUT /cleos/1.json
  def update
    respond_to do |format|
      if @cleo.update(cleo_params)
        format.html { redirect_to @cleo, notice: 'Cleo was successfully updated.' }
        format.json { render :show, status: :ok, location: @cleo }
      else
        format.html { render :edit }
        format.json { render json: @cleo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cleos/1
  # DELETE /cleos/1.json
  def destroy
    @cleo.destroy
    respond_to do |format|
      format.html { redirect_to cleos_url, notice: 'Cleo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def delete_selected
    @cleos = Cleo.find(params[:ids])
	@cleos.each do |product|
	    product.destroy
	end
	respond_to do |format|
# 	  format.html { redirect_to laetes_path, notice: 'Товары удалёны' }
	  format.json { render json: {:status => "ok", :message => "Товары удалёны"} }
	  format.js { render :nothing => true }
	end
  end
  
  
  def download
	@cleo = Cleo.delay.download
	flash[:notice] = 'Задача запущена'
	redirect_to cleos_path	
  end
  
	def insales
		Cleo.delay.insales_to_csv
		flash[:notice] = 'Задача запущена'
		redirect_to cleos_path
	end
	
  def import
    Cleo.import(params[:file])
	redirect_to cleos_path	
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cleo
      @cleo = Cleo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cleo_params
      params.require(:cleo).permit(:sku, :title, :sdesc, :desc, :cprice, :price, :qt, :image, :barcode, :dizain, :cvet, :tema, :okras, :otdelka, :zast, :kvopred, :tkan, :plotnost, :sostav, :obrazmer, :pr_razmer, :obem, :ves, :razmer_upak, :vid_upak)
    end
end
