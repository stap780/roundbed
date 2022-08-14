class PasswordResetsController < ApplicationController
  def new
  end

  def create
		user = User.find_by_email(params[:email])
		user.send_password_reset if user
		flash[:notice] = 'Вам отправлено письмо с инструкциями по смене пароля.'
		redirect_to root_url
	end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
	puts  params[:id]
    @user = User.find_by_password_reset_token!(params[:id])
    puts @user.id
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr;
        reset has expired."
    elsif 
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.save
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end

  
end
