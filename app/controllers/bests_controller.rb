class BestsController < ApplicationController
	load_and_authorize_resource
  before_action :set_best, only: [:show, :edit, :update, :destroy]

  # GET /bests
  # GET /bests.json
  def index
#     @bests = Best.all
	@search = Best.ransack(params[:q]) #используется application_controller и там в before filter :set_search
	@search.sorts = 'id asc' if @search.sorts.empty? # сортировка таблицы по id по умолчанию 
	@bests = @search.result.paginate(page: params[:page], per_page: 100)
  end

  # GET /bests/1
  # GET /bests/1.json
  def show
  end

  # GET /bests/new
  def new
    @best = Best.new
  end

  # GET /bests/1/edit
  def edit
  end

  # POST /bests
  # POST /bests.json
  def create
    @best = Best.new(best_params)

    respond_to do |format|
      if @best.save
        format.html { redirect_to @best, notice: 'Best was successfully created.' }
        format.json { render :show, status: :created, location: @best }
      else
        format.html { render :new }
        format.json { render json: @best.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bests/1
  # PATCH/PUT /bests/1.json
  def update
    respond_to do |format|
      if @best.update(best_params)
        format.html { redirect_to @best, notice: 'Best was successfully updated.' }
        format.json { render :show, status: :ok, location: @best }
      else
        format.html { render :edit }
        format.json { render json: @best.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bests/1
  # DELETE /bests/1.json
  def destroy
    @best.destroy
    respond_to do |format|
      format.html { redirect_to bests_url, notice: 'Best was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
 
  def delete_selected
    @mybest = Best.find(params[:ids])
	@mybest.each do |product|
	    product.destroy
	end
	respond_to do |format|
	  format.json { render json: {:status => "ok", :message => "Товары удалёны"} }
	  format.js { render :nothing => true }
	end
  end
  
	def download
		Best.delay.download
# 		Best.download
		flash[:notice] = 'Задача запущена'
		redirect_to bests_path	
	end
	
	def update_price
		Best.delay.update_price
		flash[:notice] = 'Задача запущена'
		redirect_to bests_path	
	end
	
	def insales
		Best.delay.insales_to_csv
		flash[:notice] = 'Задача запущена'
		redirect_to bests_path
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_best
      @best = Best.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def best_params
      params.require(:best).permit(:sku, :title, :sdesc, :desc, :cprice, :price, :qt, :image, :sv_razmer, :sv_chehol, :p_razmer, :p_napolnit, :p_visota, :p_dlina, :p_shirina, :p_ves, :p_sostav, :p_osoben, :p_tipmatrasa, :p_garant, :p_forma)
    end
end
