class AlviteksController < ApplicationController
	load_and_authorize_resource
	before_action :set_alvitek, only: [:show, :edit, :update, :destroy]

  # GET /alviteks
  # GET /alviteks.json
  def index
#     @alviteks = Alvitek.all
	@search = Alvitek.ransack(params[:q]) 
	@search.sorts = 'id asc' if @search.sorts.empty? # сортировка таблицы по id по умолчанию 
	@alviteks = @search.result.paginate(page: params[:page], per_page: 100)
  end

  # GET /alviteks/1
  # GET /alviteks/1.json
  def show
  end

  # GET /alviteks/new
  def new
    @alvitek = Alvitek.new
  end

  # GET /alviteks/1/edit
  def edit
  end

  # POST /alviteks
  # POST /alviteks.json
  def create
    @alvitek = Alvitek.new(alvitek_params)

    respond_to do |format|
      if @alvitek.save
        format.html { redirect_to @alvitek, notice: 'Alvitek was successfully created.' }
        format.json { render :show, status: :created, location: @alvitek }
      else
        format.html { render :new }
        format.json { render json: @alvitek.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alviteks/1
  # PATCH/PUT /alviteks/1.json
  def update
    respond_to do |format|
      if @alvitek.update(alvitek_params)
        format.html { redirect_to @alvitek, notice: 'Alvitek was successfully updated.' }
        format.json { render :show, status: :ok, location: @alvitek }
      else
        format.html { render :edit }
        format.json { render json: @alvitek.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alviteks/1
  # DELETE /alviteks/1.json
  def destroy
    @alvitek.destroy
    respond_to do |format|
      format.html { redirect_to alviteks_url, notice: 'Alvitek was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def download
	@alvitek = Alvitek.delay.download
	flash[:notice] = 'Задача запущена'
	redirect_to alviteks_path	
  end
  
	def insales
		Alvitek.delay.insales_to_csv
		flash[:notice] = 'Задача запущена'
		redirect_to alviteks_path
	end
	
  def import
    Alvitek.import(params[:file])
	redirect_to alviteks_path	
  end
  
	def delete_selected
		@alviteks = Alvitek.find(params[:ids])
		@alviteks.each do |item|
		    item.destroy
		end
		respond_to do |format|
		  format.html { redirect_to items_url, notice: 'Товары удалёны' }
		  format.json { render json: {:status => "ok", :message => "Товары удалёны"} }
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alvitek
      @alvitek = Alvitek.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alvitek_params
      params.require(:alvitek).permit(:aid, :sku, :title, :desc, :qt, :price, :mprice, :image, :cat, :col, :vendor, :country, :line, :razmer, :teplota, :podderjka, :razm_nav, :razm_podod, :razmer_prostini, :tip_prostini, :visota, :napolnitel, :napolnitel_chehla, :napolnitel_yadra, :ves_napolnitel, :ves_nopolnitel_chehla, :ves_napolnitel_yadra, :tkan, :sostav_tkan, :tip_zast, :tip_zast_navol, :tip_zast_podod, :tip_krepl, :tip_stejki, :okantovka, :upak, :tip_upak, :kol_upak, :material, :plotnost, :barcode, :cvet, :tkan_verh, :tkan_niz, :sostav)
    end
end
