class LaeteMailer < ApplicationMailer
	
layout 'laete_mailer'
	
	def download(productbefore, productafter)
		@productbefore = productbefore
		@productafter = productafter
		@app_name = 'Roundbed - управление поставщиками'
			
		mail to: 'dmitriylimin@mail.ru, panaet80@gmail.com',
		     subject: "Laete - загрузка и обновление - Робот Roundbed",
		     from: "info@roundbed.ru",
		     reply_to: "info@roundbed.ru"
	end
	
	def insales
		@app_name = 'Roundbed - управление поставщиками'
			
		mail to: 'dmitriylimin@mail.ru, panaet80@gmail.com',
		     subject: "Laete - формирование файла insales - Робот Roundbed",
		     from: "info@roundbed.ru",
		     reply_to: "info@roundbed.ru"
	end
	
	
end
