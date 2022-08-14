class MarcsController < ApplicationController
	load_and_authorize_resource
	before_action :set_marc, only: [:show, :edit, :update, :destroy]

  # GET /marcs
  # GET /marcs.json
  def index
#     @marcs = Marc.all
	@search = Marc.ransack(params[:q]) #используется application_controller и там в before filter :set_search
	@search.sorts = 'id asc' if @search.sorts.empty? # сортировка таблицы по id по умолчанию 
	@marcs = @search.result.paginate(page: params[:page], per_page: 100)
  end

  # GET /marcs/1
  # GET /marcs/1.json
  def show
  end

  # GET /marcs/new
  def new
    @marc = Marc.new
  end

  # GET /marcs/1/edit
  def edit
  end

  # POST /marcs
  # POST /marcs.json
  def create
    @marc = Marc.new(marc_params)

    respond_to do |format|
      if @marc.save
        format.html { redirect_to @marc, notice: 'Marc was successfully created.' }
        format.json { render :show, status: :created, location: @marc }
      else
        format.html { render :new }
        format.json { render json: @marc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marcs/1
  # PATCH/PUT /marcs/1.json
  def update
    respond_to do |format|
      if @marc.update(marc_params)
        format.html { redirect_to @marc, notice: 'Marc was successfully updated.' }
        format.json { render :show, status: :ok, location: @marc }
      else
        format.html { render :edit }
        format.json { render json: @marc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marcs/1
  # DELETE /marcs/1.json
	def destroy
		@marc.destroy
		respond_to do |format|
		  format.html { redirect_to marcs_url, notice: 'Marc was successfully destroyed.' }
		  format.json { head :no_content }
		end
	end
  
	def image
		Marc.delay.get_image
		flash[:notice] = 'Задача запущена'
		redirect_to marcs_path
	end
	
	def desc
		Marc.delay.get_desc
		flash[:notice] = 'Задача запущена'
		redirect_to marcs_path
	end
	
	def insales
		Marc.delay.insales_to_csv
		flash[:notice] = 'Задача запущена'
		redirect_to marcs_path
	end
	
	def import
		Marc.import(params[:file])
		redirect_to marcs_path	
	end
  
	def delete_selected
		@marcs = Marc.find(params[:ids])
		@marcs.each do |item|
		    item.destroy
		end
		respond_to do |format|
		  format.html { redirect_to items_url, notice: 'Товары удалёны' }
		  format.json { render json: {:status => "ok", :message => "Товары удалёны"} }
		end
	end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marc
      @marc = Marc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marc_params
      params.require(:marc).permit(:sku, :title, :sdesc, :desc, :cprice, :price, :qt, :image, :razmer, :cvet, :razmer2, :sostav, :url)
    end
end
