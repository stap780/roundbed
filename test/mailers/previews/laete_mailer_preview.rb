# Preview all emails at http://localhost:3000/rails/mailers/laete_mailer
class LaeteMailerPreview < ActionMailer::Preview
	
	def download
		productbefore = '100'
		productafte = '101'
    LaeteMailer.download(productbefore, productafte)
	end
	
	def insales
    LaeteMailer.insales
	end

end
