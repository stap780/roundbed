class BestMailer < ApplicationMailer
	
layout 'best_mailer'
	
	def download(productbefore, productafter)
		@productbefore = productbefore
		@productafter = productafter
		@app_name = 'Roundbed - управление поставщиками'
			
		mail to: 'dmitriylimin@mail.ru, panaet80@gmail.com',
		     subject: "Best - загрузка и обновление - Робот Roundbed",
		     from: "info@roundbed.ru",
		     reply_to: "info@roundbed.ru"
	end
	
	def insales
		@app_name = 'Roundbed - управление поставщиками'
			
		mail to: 'dmitriylimin@mail.ru, panaet80@gmail.com',
		     subject: "Best - формирование файла insales - Робот Roundbed ",
		     from: "info@roundbed.ru",
		     reply_to: "info@roundbed.ru"
	end
	
	
end
