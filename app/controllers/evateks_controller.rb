class EvateksController < ApplicationController
	load_and_authorize_resource
	before_action :set_evatek, only: [:show, :edit, :update, :destroy]

  # GET /evateks
  # GET /evateks.json
  def index
#     @evateks = Evatek.all
	@search = Evatek.ransack(params[:q]) #используется application_controller и там в before filter :set_search
	@search.sorts = 'id asc' if @search.sorts.empty? # сортировка таблицы по id по умолчанию 
	@evateks = @search.result.paginate(page: params[:page], per_page: 100)
  end

  # GET /evateks/1
  # GET /evateks/1.json
  def show
  end

  # GET /evateks/new
  def new
    @evatek = Evatek.new
  end

  # GET /evateks/1/edit
  def edit
  end

  # POST /evateks
  # POST /evateks.json
  def create
    @evatek = Evatek.new(evatek_params)

    respond_to do |format|
      if @evatek.save
        format.html { redirect_to @evatek, notice: 'Evatek was successfully created.' }
        format.json { render :show, status: :created, location: @evatek }
      else
        format.html { render :new }
        format.json { render json: @evatek.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evateks/1
  # PATCH/PUT /evateks/1.json
  def update
    respond_to do |format|
      if @evatek.update(evatek_params)
        format.html { redirect_to @evatek, notice: 'Evatek was successfully updated.' }
        format.json { render :show, status: :ok, location: @evatek }
      else
        format.html { render :edit }
        format.json { render json: @evatek.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evateks/1
  # DELETE /evateks/1.json
  def destroy
    @evatek.destroy
    respond_to do |format|
      format.html { redirect_to evateks_url, notice: 'Evatek was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_selected
    @evatek = Evatek.find(params[:ids])
	@evatek.each do |product|
	    product.destroy
	end
	respond_to do |format|
	  format.html { redirect_to laetes_path, notice: 'Товары удалёны' }
	  format.json { render json: {:status => "ok", :message => "Товары удалёны"} }
	  format.js { render :nothing => true }
	end
  end

  def download
	@evatek = Evatek.delay.download
	flash[:notice] = 'Задача запущена'
	redirect_to evateks_path	
  end
  
	def insales
		Evatek.delay.insales_to_csv
		flash[:notice] = 'Задача запущена'
		redirect_to evateks_path
	end
	
	def file_import
		respond_to do |format|
		  format.js
		end     
	end

  def import
    Evatek.import(params[:file])
	redirect_to evateks_path	
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evatek
      @evatek = Evatek.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evatek_params
      params.require(:evatek).permit(:eid, :url, :title, :sku, :cprice, :sdesc, :desc, :price, :oprice, :qt, :razmer_eu, :razmer_ru, :uzor, :cvet, :sostav, :weight, :vendor, :col, :country, :image)
    end
end
