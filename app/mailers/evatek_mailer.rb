class EvatekMailer < ApplicationMailer


layout 'evatek_mailer'

	def download(productbefore, productafter)
		@productbefore = productbefore
		@productafter = productafter
		@app_name = 'Roundbed - управление поставщиками'

		mail to: 'dmitriylimin@mail.ru',
		     subject: "Evatek - загрузка и обновление - Робот Roundbed",
		     from: "info@roundbed.ru",
		     reply_to: "info@roundbed.ru"
	end

	def insales
		@app_name = 'Roundbed - управление поставщиками'

		mail to: 'dmitriylimin@mail.ru',
		     subject: "Evatek - формирование файла insales - Робот Roundbed ",
		     from: "info@roundbed.ru",
		     reply_to: "info@roundbed.ru"
	end



end
