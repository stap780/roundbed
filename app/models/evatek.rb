class Evatek < ActiveRecord::Base
	validates :eid, uniqueness: true
	
	def self.download
		puts "start Evatek download"
# 	Evatek.destroy_all
sizes_ru = ["54-56", "42-44", "50-52", "44-46", "48-50", "46-48", "52", "50", "48", "58-60", "52-54", "85x150 см.", "56-58", "62-64", "50x100см. и 70x140см.", "56", "46", "60-62", "54", "42-48", "42", "44", "12 лет", "92-104 см", "50x100 см.", "70x140 см.", "40-42", "50x32x14 см.", "36x26x5 см.", "41х31х12", "42-46", "64-66", "56/58", "58", "14 лет", "16 лет", "16 лет (152-158)", "14 лет (146-152)", "12 лет (140-146)", "2 года", "3 года", "4 года", "5 лет", "6 лет", "4-5 лет", "6-7 лет", "1 год", "2-3 года", "2-4 года (92-104)", "50*90 см.", "70*140 см.", "50x80 см.", "70х140-2шт.", "50х100-1 шт.", "50х100-2 шт.", "50*70", "4-6 лет (110-116)", "6-8 лет (122-128)", "10 лет (134-140 см)", "4-6 года (110-116 см)"]
sizes_eu = ["XL", "S", "M", "L", "XXL", "2XL", "S/M", "L/XL", "4XL", "3XL", "XS-L", "XS", "one size", "5XL", "6XL", "М"]

		productbefore = Evatek.count
		uri = "https://evateks.ru/export/?type=xml&brand=1&brand=15&brand=2&brand=13&brand=67&brand=36&brand=94&brand=38&add=Category&add=Postel&add=Dimensions&add=Description"
	
	    response = RestClient.get uri, :accept => :xml, :content_type => "application/xml"
	    data = Nokogiri::XML(response)
	    product = "Items/Item"
	    mypr = data.xpath(product)
		
		mypr.each do |pr|
			item_id = pr["id"]
# 			if item_id == '31103'
			title = pr.xpath("Caption").text
			url = "https://evateks.ru/store.aspx?id="+item_id
			price = pr.xpath("Price").text
			cat = pr.xpath("Category").text

			pict = []
			mainpict = pr.xpath("Picture")
			pict.push(mainpict.text)
			picts = pr.xpath("Photos/Photo")
			picts.each do |pic|
				pict.push(pic.text)
			end
			image = pict.join(' ')
# 			p1 = pr.xpath("param [@name='Количество ягод']").text 			
			cvet = pr.xpath("Color").text.strip
			sostav = pr.xpath("Composition").text.strip
			sdesc = ''
			desc = pr.xpath("Description").text+"<p>"+cat+"</p>"
			weight = pr.xpath("Weight").text
			vendor = pr.xpath("Producer").text
			col = pr.xpath("Collection").text
			country = pr.xpath("Country").text
			
			file_razmer = pr.xpath("Size").text.gsub('one size ','').split(',')
			file_razmer.each do |razmer|
# 				puts 'razmer - '+razmer.to_s
				razmer_eu_ar = []
				razmer_ru_ar = []
				if razmer.include?('(') && razmer.split('(').size > 1
					razmer_eu_ar.push(razmer.split('(')[0].strip)
					razmer_ru_ar.push(razmer.split('(')[1].gsub(')','').strip)
				else
					search_eu = sizes_eu.include?(razmer.gsub('(','').gsub(')','').strip) ? razmer.gsub('(','').gsub(')','').strip : ''
					razmer_eu_ar.push(search_eu.strip)
					search_ru = sizes_ru.include?(razmer.gsub('(','').gsub(')','').strip) ? razmer.gsub('(','').gsub(')','').strip : ''
					razmer_ru_ar.push(search_ru.strip)
				end
				razmer_eu = razmer_eu_ar.compact.join
				razmer_ru = razmer_ru_ar.compact.join
# 				puts "razmer_eu - "+razmer_eu.to_s
# 				puts "razmer_ru - "+razmer_ru.to_s
				if razmer_eu.present?
					eid = item_id.to_s+"-"+razmer_eu.to_s
				else
					eid = item_id.to_s+"-"+razmer_ru.to_s
				end
				
				evatek = Evatek.find_by_eid(eid)
				if evatek
					evatek.update_attributes(:url => url, :title => title, :price => price, :sostav => sostav, :image => image, :sdesc => sdesc, :desc => desc, :weight => weight, :vendor => vendor, :col => col, :country => country )#, :razmer_ru => razmer_ru, :cvet => cvet
				else
					Evatek.create(:eid => eid, :url => url, :title => title, :price => price, :razmer_eu => razmer_eu, :razmer_ru => razmer_ru, :cvet => cvet, :sostav => sostav, :image => image, :sdesc => sdesc, :desc => desc, :weight => weight, :vendor => vendor, :col => col, :country => country )
				end
			end
			
# 			end
	  	end
		
# 	  	Evatek.oldprice
		productafter = Evatek.count
		EvatekMailer.download(productbefore, productafter).deliver_now
		puts "finish Evatek download"
	end
	
	def self.insales_to_csv
		puts "Файл Evatek инсалес"
		file_ins = "#{Rails.public_path}"+'/insales_evatek.csv'
		check = File.file?(file_ins)
		if check.present?
			File.delete(file_ins)
		end
		
		@evateks = Evatek.where.not(sku: [nil, '']).order(:id)
		file = "#{Rails.root}/public/insales_evatek.csv"
		CSV.open( file, 'w') do |writer|
		headers = ['title', 'sdesc', 'desc','sku', 'image', 'cost-price', 'price', 'old-price', 'quantity', 'ves', 'SV_razmer_eu', 'SV_razmer_ru', 'SV_cvet', 'Param-uzor','Param-sostav', 'Param-strana', 'Param-Col', 'Param-Vendor', 'Kornevai']

		writer << headers
		@evateks.each do |pr|
# 			puts pr.id
			title = pr.title
			sku = pr.sku
			image = pr.image
			cprice = pr.cprice
			price = pr.price
			oprice = pr.oprice
			qt = pr.qt
			razmer_eu = pr.razmer_eu
			razmer_ru = pr.razmer_ru
			cvet = pr.cvet
			uzor = pr.uzor
			sostav = pr.sostav
			sdesc = pr.sdesc
			desc = pr.desc
			weight = pr.weight
			vendor = pr.vendor
			country = pr.country
			col = pr.col
			writer << [title, sdesc, desc, sku, image, cprice, price, oprice, qt, weight , razmer_eu, razmer_ru,  cvet, uzor , sostav, country, col, vendor, 'Evatek' ]
			end 
		end #CSV.open    
		
		EvatekMailer.insales.deliver_now
		puts 'Файл Evatek инсалес сформирован'
	end
	
	def self.oldprice
		require 'mechanize'
		a = Mechanize.new
		url = "https://evateks.ru/tryLogin.ashx"
		a.post(url, {"mail" => "finenko72@hotmail.com", "pass" => "123456"})
		a.cookie_jar.save_as('ASP.NET_SessionId')
		products_pages = ['https://evateks.ru/store.aspx?sec_id=125&show=all','https://evateks.ru/store.aspx?sec_id=126&show=all','https://evateks.ru/store.aspx?sec_id=1276&show=all','https://evateks.ru/store.aspx?sec_id=128&show=all','https://evateks.ru/store.aspx?sec_id=131&show=all','https://evateks.ru/store.aspx?sec_id=132&show=all','https://evateks.ru/store.aspx?sec_id=25&show=all']

# 		products = Evatek.order(:id)
# 		
# 		products.each do |p|
# 			doc = a.get(p.url)
# 			cprice = doc.css('.itemOptPrices .half-size .main-p').text.split(' ')[0]
# 			price = doc.css('.itemOptPrices .half-size .roznPrice').text.split(' ')[0]
# 			p.update_attributes(price: price, cprice: cprice)
# 		end
		
		products_pages.each do |pp|
			doc = a.get(pp)
			products_block = doc.css('.itemsBlock')[1]
			if !products_block.nil?
			products = products_block.css('.item')
				products.each do |pr|
					if pr.css('a').present?
						id = pr.css('a')[0]['href'].split('=').last
						cprice = pr.css('.itemPrice').text.split(' ')[0]
	# 					price = doc.css('.roznPrice').text.split(' ')[0]
						evateks = Evatek.where(eid: id)
						evateks.each do |evatek|
							evatek.update_attributes(cprice: cprice)
						end
					end
				end
			end
		end
		
	end
	
	def self.import(file)
		Evatek.update_all(:qt => '0')
		colors = Evatek.pluck(:cvet).compact.uniq
		sizes_ru = Evatek.pluck(:razmer_ru).compact.uniq
		sizes_eu = Evatek.pluck(:razmer_eu).compact.uniq
		
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(7)
		(8..spreadsheet.last_row).each do |i|
		     
			row = Hash[[header, spreadsheet.row(i)].transpose]
			sku = row["Штрихкод"].to_s
			svoistva = row["Характеристика"].to_s.gsub('цв.',' ').gsub('р-р:',' ').gsub('(',' ').gsub(')',' ').strip.split(' ')
			puts svoistva
			qt = row["В наличии Остаток"].to_s
			cprice = spreadsheet.cell(i,'K').to_s.strip if spreadsheet.cell(i,'K') !=nil
			pseudo_sku = row["Артикул"].to_s			
			#sizes.any? {|s| svoistva.include?(s)}
			size_eu = (sizes_eu & svoistva)[0]
			size_ru = (sizes_ru & svoistva)[0]
			color = (colors & svoistva)[0]
			
			evateks = Evatek.where(sku: sku)
			evateks.each do |evatek|
				evatek.update_attributes(qt: qt, cprice: cprice)
			end
			
			if !svoistva.include?('ДИСКОНТ')
			evatek_with_ru = Evatek.where("title LIKE ? and cvet = ? and razmer_ru = ?", "%#{pseudo_sku}%", color, size_ru).first
			if evatek_with_ru
				evatek_with_ru.update_attributes(sku: sku)
			end
			evatek_with_eu = Evatek.where("title LIKE ? and cvet = ? and razmer_eu = ?", "%#{pseudo_sku}%", color, size_eu).first
			if evatek_with_eu
				evatek_with_eu.update_attributes(sku: sku)
			end
			end
		end
		
	end
	
	
	def self.open_spreadsheet(file)
	    case File.extname(file.original_filename)
	    when ".csv" then Roo::CSV.new(file.path, csv_options: {col_sep: ";"})
	    when ".xls" then Roo::Excel.new(file.path)
	    when ".xlsx" then Roo::Excelx.new(file.path)
	    when ".XLS" then Roo::Excel.new(file.path)
	    else raise "Unknown file type: #{file.original_filename}"
	    end
	end
	
end
