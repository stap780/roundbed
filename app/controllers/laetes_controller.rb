class LaetesController < ApplicationController
	load_and_authorize_resource
	before_action :set_laete, only: [:show, :edit, :update, :destroy]

  # GET /laetes
  # GET /laetes.json
  def index
#     @laetes = Laete.all
	@search = Laete.ransack(params[:q]) #используется application_controller и там в before filter :set_search
	@search.sorts = 'id asc' if @search.sorts.empty? # сортировка таблицы по id по умолчанию 
	@laetes = @search.result.paginate(page: params[:page], per_page: 100)
  end

  # GET /laetes/1
  # GET /laetes/1.json
  def show
  end

  # GET /laetes/new
  def new
    @laete = Laete.new
  end

  # GET /laetes/1/edit
  def edit
  end

  # POST /laetes
  # POST /laetes.json
  def create
    @laete = Laete.new(laete_params)

    respond_to do |format|
      if @laete.save
        format.html { redirect_to @laete, notice: 'Laete was successfully created.' }
        format.json { render :show, status: :created, location: @laete }
      else
        format.html { render :new }
        format.json { render json: @laete.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /laetes/1
  # PATCH/PUT /laetes/1.json
  def update
    respond_to do |format|
      if @laete.update(laete_params)
        format.html { redirect_to @laete, notice: 'Laete was successfully updated.' }
        format.json { render :show, status: :ok, location: @laete }
      else
        format.html { render :edit }
        format.json { render json: @laete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /laetes/1
  # DELETE /laetes/1.json
  def destroy
    @laete.destroy
    respond_to do |format|
      format.html { redirect_to laetes_url, notice: 'Laete was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def download
	@laete = Laete.delay.download
	flash[:notice] = 'Задача запущена'
	redirect_to laetes_path	
  end
  
	def insales
		Laete.delay.insales_to_csv
		flash[:notice] = 'Задача запущена'
		redirect_to laetes_path
	end
	
  def delete_selected
    @laetes = Laete.find(params[:ids])
	@laetes.each do |product|
	    product.destroy
	end
	respond_to do |format|
	  format.html { redirect_to laetes_path, notice: 'Товары удалёны' }
	  format.json { render json: {:status => "ok", :message => "Товары удалёны"} }
	  format.js { render :nothing => true }
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_laete
      @laete = Laete.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def laete_params
      params.require(:laete).permit(:lid, :url, :title, :sku, :price, :qt, :razmer_eu, :razmer_ru, :uzor, :cvet, :sostav, :image, :cprice, :oprice, :sdesc, :desc)
    end
end
