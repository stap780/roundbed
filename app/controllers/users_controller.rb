class UsersController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:newuser, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
	@permcl = Permcl.all.order(:id)
	@permcl_action = PermclAction.all.order(:id)
  end

  def newuser
    @user = User.new
    puts 'здесь newuser'
    puts params
  end

  # GET /users/1/edit
  def edit
    @permcl = Permcl.all.order(:id)
	  @permcl_action = PermclAction.all.order(:id)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    puts user_params
    if @user.save
      puts 'здесь user create'
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      puts 'здесь user render new'
      render "new"
    end
end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      respond_to do |format|
      	if @user.update(user_params)

  			puts params[:role]
  			if params[:role] == 'manager'
  			    params[:permissions].each do |k,v|
  					user_id = v[:user_id]
  					permcl_id = v[:permcl_id]
  					permcl_action_ids = v[:permcl_action_ids]
  					permcl_action_ids.each do |permcl_action_id_k, permcl_action_id_v|
  					action_value = permcl_action_id_v[:action_value]
  					@permission = Permission.where(user_id: user_id, permcl_id: permcl_id, permcl_action_id: permcl_action_id_k)
  					if @permission.present?
  					  puts 'запись о доступе есть'
  					  puts v
  						if action_value == '1'
  					  #если стоит 1 (то разрешать доступ), то правило нужно сохранить
  					  else
  					  	@permission.each do |p|
  						  	p.delete
  						  end
  						 end
  					else
  						puts 'запись о доступе отсутствует'
  						if action_value == '1'
  							#если стоит 1 (то разрешать доступ), то правило нужно создать
  							Permission.create(user_id: user_id, permcl_id: permcl_id, permcl_action_id: permcl_action_id_k)
  						end
  					end
  				end
  			end
  			else
  			  @user.permissions.destroy_all
  			end

  		format.html { redirect_to @user, notice: 'User was successfully updated.' }
  		format.json { render :show, status: :ok, location: @user }
  		else
  		format.html { render :edit }
  		format.json { render json: @user.errors, status: :unprocessable_entity }
  		end
  	end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :password_digest, :auth_token, :password_reset_token, :password_reset_sent_at, :role, :permission_attributes => [:user_id, :permcl_id, :permcl_action_id, :id, :_destroy])
    end
end
