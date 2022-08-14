class UserMailer < ApplicationMailer
layout 'user_mailer'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
		@user = user
		@app_name = 'GoApp - our app'
		mail :to => user.email, 
		subject: "Password Reset",
		from: "info@roundbed.ru",
		reply_to: "info@roundbed.ru"
  end
end
