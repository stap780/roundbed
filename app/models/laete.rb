class Laete < ActiveRecord::Base
	
	validates :lid, uniqueness: true

		
	def self.download
		puts "start Laete download"
# 	Laete.destroy_all
		productbefore = Laete.count
		uri = "https://opt.laete.ru/get_xml/"
	
	    response = RestClient.get uri, :accept => :xml, :content_type => "application/xml"
	    data = Nokogiri::XML(response)
	    product = "yml_catalog/shop/offers/offer"
	    mypr = data.xpath(product)
	    cat = "yml_catalog/shop/categories/category"
	    mycat = data.xpath(cat)
	    Laete.update_all(:qt=>0)
	    
		
		mypr.each do |pr|
			lid = pr["id"]
			sku = pr.xpath("articul").text
			title = pr.xpath("name").text
			url = pr.xpath("url").text#.split('?')[0] 
			cprice = pr.xpath("price").text
			price = cprice.to_i*2
			cat_id = pr.xpath("categoryId").text
			cat = "yml_catalog/shop/categories/category"
			mycat = data.xpath(cat)
			mycat.each do |c|
				id = c["id"]
				if cat_id == id
				@category_text = c.text
				else
				@category_text = ''
				end
			end 
			pict = []
			picts = pr.xpath("picture")
			picts.each do |pic|
				pict.push(pic.text)
			end
			image = pict.to_s.gsub('"','').gsub('[','').gsub(']','').gsub(',','')
			qt = pr.xpath("quantity").text
			
# 			p1 = pr.xpath("param [@name='Количество ягод']").text 
			full_razmer = pr.xpath("Размер").text
# 			puts full_razmer.split('(').size
			if full_razmer.split('(').size == 1
				if full_razmer.include?("L") || full_razmer.include?("M") || full_razmer.include?("S")
					razmer_eu = full_razmer
					razmer_ru = ''
				else
				razmer_eu = ''
				razmer_ru = full_razmer
				end
			else
			razmer_eu = full_razmer.split('(')[0]
			razmer_ru = full_razmer.split('(')[1].gsub('(','').gsub(')','') if full_razmer.split('(')[1] != nil
			end
			uzor = pr.xpath("Узор").text 
			cvet = pr.xpath("Цвет").text  
			sostav = pr.xpath("Состав").text
			sdesc = title.gsub("#{sku}", "").gsub('()','').gsub('000','').strip
			puts sdesc
			puts @category_tex
			if @category_text.include?('Линия') || @category_text.include?('Распродажа') || @category_text.include?('SALE') || @category_text.include?('Скоро в продаже') || @category_text.include?('оптом')
			desc = title.gsub("#{sku}", "").gsub('()','').gsub('000','').strip
			else
			desc = title.gsub("#{sku}", "").gsub('()','').gsub('000','').strip+". "+@category_text
			end
			
			@laete = Laete.where("lid = ?", lid)
			if @laete.present?
				@laete.each do |p|
				p.update_attributes(:url => url, :title => title, :sku => sku, :cprice => cprice, :price => price, :qt => qt, :razmer_eu => razmer_eu, :razmer_ru => razmer_ru, :uzor => uzor, :cvet => cvet, :sostav => sostav, :image => image, :sdesc => sdesc, :desc => desc)
				end
			else
				Laete.create(:lid => lid, :url => url, :title => title, :sku => sku, :cprice => cprice, :price => price, :qt => qt, :razmer_eu => razmer_eu, :razmer_ru => razmer_ru, :uzor => uzor, :cvet => cvet, :sostav => sostav, :image => image, :sdesc => sdesc, :desc => desc)
			end
	  	end
		
		Laete.oldprice
		productafter = Laete.count
		LaeteMailer.download(productbefore, productafter).deliver_now
		puts "finish Laete download"
	end
	
	def self.insales_to_csv
		puts "Файл Laete инсалес"
		file_ins = "#{Rails.public_path}"+'/insales_laete.csv'
		check = File.file?(file_ins)
		if check.present?
			File.delete(file_ins)
		end
		
			@laete = Laete.all.order(:id)
			file = file_ins#"#{Rails.root}/public/insales_laete.csv"
			CSV.open( file, 'w') do |writer|
			headers = ['title', 'sdesc', 'desc','sku', 'image', 'cost-price', 'price', 'old-price', 'quantity', 'SV_razmer_eu', 'SV_razmer_ru', 'SV_cvet', 'Param-uzor','Param-sostav', 'Param-strana', 'Param-Vendor', 'Kornevai']

			writer << headers
			@laete.each do |pr|
# 			puts pr.id
				title = pr.title
				sku = pr.sku
				image = pr.image
				cprice = pr.cprice
				price = pr.price
				oprice = pr.oprice
				qt = pr.qt
# 				puts qt
				razmer_eu = pr.razmer_eu
				razmer_ru = pr.razmer_ru
				cvet = pr.cvet
				uzor = pr.uzor
				sostav = pr.sostav
				sdesc = pr.sdesc
				desc = pr.desc
				writer << [title, sdesc, desc, sku, image, cprice, price, oprice, qt, razmer_eu, razmer_ru,  cvet, uzor , sostav, 'Россия', 'Laete', 'Laete' ]
				end 
			end #CSV.open    
		
	#   ProductMailer.alfadetali_product(@products_alfa).deliver_now
		puts 'Файл Laete инсалес сформирован'
	LaeteMailer.insales.deliver_now
	end
	
	def self.oldprice
		require 'mechanize'
		a = Mechanize.new
		a.get("https://opt.laete.ru/personal/")
		form = a.page.forms.last
		form.USER_LOGIN = "finenko72@hotmail.com"
		form.USER_PASSWORD = "123456"
		form.submit
		doc = a.get("https://opt.laete.ru/collection/rasprodazha/?COUNT=999")
		products = doc.css('.section__prod-info')
		products.each do |p|
			sku = p.css('.section__prod-article').text
			oprice_site = p.css(".section__prod-oldprice").text.gsub(' руб.','')
# 			puts p.css(".section__prod-price").text.strip.split('руб.')
# 			price_site = p.css(".section__prod-price").text.strip.split('руб.')[1].strip.gsub(' ','')
			oprice = oprice_site.to_i*2
			laetes = Laete.where(:sku => sku)
			laetes.each do |laete|
				laete.update_attributes(oprice: oprice)
			end
		end
	end
	
	
end
