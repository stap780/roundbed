class Marc < ActiveRecord::Base
	before_update :update_desc
	
	def self.import(file)
# 		Marc.destroy_all
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(3)
		(6..spreadsheet.last_row).each do |i|
		     
			row = Hash[[header, spreadsheet.row(i)].transpose]
	# 		puts row.inspect
	
# 			sku = row["Артикул"].to_s.strip if row["Артикул"] !=nil
# 			title = row["Наименование"].to_s.strip if row["Наименование"] !=nil
# 			sdesc = ''
# 			desc = row["Текстовое описание"].to_s.strip if row["Текстовое описание"] !=nil
# 			cprice = row["Цена Ваша"]#.to_s.strip if row["Цена Ваша"] !=nil
# 			price = row["Цена РРЦ"]#.to_s.strip if row["Цена РРЦ"] !=nil
# 			qt = row["В наличии"].to_s.strip if row["В наличии"] !=nil
# 			cvet = row["Цвет"].to_s.strip if row["Цвет"] !=nil
# 
# 			puts row["Цена Ваша"]
# 			
# 			razmer_fail = row["Размер"].to_s.strip if row["Размер"] !=nil

			sku = spreadsheet.cell(i,'A').to_s.strip if spreadsheet.cell(i,'A') !=nil
			title = spreadsheet.cell(i,'B').to_s.strip if spreadsheet.cell(i,'B') !=nil
			sdesc = ''
			desc = spreadsheet.cell(i,'E').to_s.strip if spreadsheet.cell(i,'E') !=nil
			cprice = spreadsheet.cell(i,'H').to_s.strip if spreadsheet.cell(i,'H') !=nil
			price = spreadsheet.cell(i,'I').to_s.strip if spreadsheet.cell(i,'I') !=nil
			qt = spreadsheet.cell(i,'G').to_s.strip if spreadsheet.cell(i,'G') !=nil
			cvet = spreadsheet.cell(i,'D').to_s.strip if spreadsheet.cell(i,'D') !=nil
			razmer_fail = spreadsheet.cell(i,'C').to_s.strip if spreadsheet.cell(i,'C') !=nil

			if !razmer_fail.nil?
				@razmer = spreadsheet.excelx_value(i,'C').to_s.strip if spreadsheet.excelx_value(i,'C') !=nil
				if spreadsheet.excelx_type(i, 'C').to_s != "string"
					if spreadsheet.excelx_type(i, 'C').to_s.split('_').count == 4
						@razmer2 = spreadsheet.excelx_type(i, 'C').to_s.split('_').last.to_s.gsub('\""]','')
					else
						@razmer2 = ''
					end
				end
# 			puts "title - "+"#{title}"
			puts @razmer2
			puts "excelx_type - "+spreadsheet.excelx_type(i,'C').to_s
			puts "excelx_value - "+spreadsheet.excelx_value(i, 'C').to_s
			# puts spreadsheet.formatted_value(i,'C')
			puts "razmer - "+spreadsheet.cell(i,'C').to_s
				marcs = Marc.where(:title => title, :razmer => @razmer, :razmer2 => @razmer2, :cvet => cvet)
				if marcs.present?
					marcs.each do |marc|
						marc.update_attributes(sku: sku, sdesc: sdesc, desc: desc, qt: qt, cprice: cprice, price: price, razmer: @razmer, razmer2: @razmer2, cvet: cvet)
					end
				else
					Marc.create(sku: sku, title: title, sdesc: sdesc, desc: desc, qt: qt, cprice: cprice, price: price, razmer: @razmer, razmer2: @razmer2, cvet: cvet)
 				end
			end
		end
# 		Marc.get_image
	end
	
	def self.get_image
		# нужно поменять импорт картинки и описания - https://marcandre.com/search/index.php?q=BA18-11
		marcs = Marc.where(image: [nil, '']).order(:id)#.limit(8)
		marcs.each do |mark|
		url = "https://marcandre.com/search/index.php?q="+mark.sku
			RestClient.get( url ) { |response, request, result, &block|
				case response.code
				when 200
				doc = Nokogiri::HTML(open(url, :read_timeout => 30))
				products = doc.css('.product-item__wrap .main-content .product-item-image-wrapper')
# 				puts products
# 				puts products.count
				product_link = products.map{|p| p.attributes['href'].value if p.attributes['title'].value.include?(mark.sku)}[0]
				if product_link.present?
					pr_doc = Nokogiri::HTML(open("https://marcandre.com"+product_link, :read_timeout => 30))
					picts = []
					tumb_picts = pr_doc.css(".product-item-detail-slider-container .product-item-detail-slider-controls-block .product-item-detail-slider-controls-image img")
					if tumb_picts.size > 0
						tumb_picts.each do |dp|
							p = "https://marcandre.com"+dp['data-webp-src']
							picts.push(p)
					 	end
				 	else
				 		one_pict = pr_doc.css(".product-item-detail-slider-image.active img").present? ? "https://marcandre.com"+pr_doc.css(".product-item-detail-slider-image.active img")[0].attributes['src'].value : ''
				 		picts.push(one_pict)
				 	end
				 	pict = picts.uniq.join(' ')
				 	desc = pr_doc.css('#product_description').inner_html
					chars = pr_doc.css("#product_characteristics span")
					chars.each do |c|
						if c.css('dt').text.strip == 'Состав'
							@sostav = c.css('dd').text.strip
						end
					end
				 	mark.update_attributes(sostav: @sostav, desc: desc, image: pict, url: "https://marcandre.com"+product_link)
			 	end
				when 404
					puts "error 404 - "+url	
				when 422
					puts '422'
				else
					response.return!(&block)
				end
				}
		end

	end
	
	def self.get_desc
# 		marcs = Marc.where(:sdesc => '')
# 		marcs.each do |mark|
# 		url_sku = mark.sku.gsub('/','-')
# 		url = "https://shop.marcandandre.com/rus-ru/"+"#{url_sku}"+".html"
# 			RestClient.get( url ) { |response, request, result, &block|
# 				puts response.code
# 				case response.code
# 				when 200
# 				doc = Nokogiri::HTML(open(url, :read_timeout => 300))
# 				sdesc = doc.css(".site-product-short-description").text
# 				chars = doc.css("#product_characteristics span")
# 				chars.each do |c|
# 					if c.css('dt').text.strip == 'Состав:'
# 						@sostav = c.css('dd').text.strip
# 					end
# 				end
# 			 	mark.sdesc = sdesc
# 			 	mark.sostav = @sostav
# 				mark.save
# 				when 404
# 				puts url	
# 				when 422
# 					puts '422'
# 				else
# 					response.return!(&block)
# 				end
# 				}
# 		end
	end

	def self.insales_to_csv
		puts "Файл Marc инсалес"
		
			file_ins = "#{Rails.public_path}"+'/insales_marc.csv'
			check = File.file?(file_ins)
			if check.present?
				File.delete(file_ins)
			end
			
			@marcs = Marc.all.order(:id)#.limit(2)
			file = "#{Rails.root}/public/insales_marc.csv"
			CSV.open( file, 'w') do |writer|
			headers = ['sku', 'title', 'sdesc', 'desc', 'quantity', 'cost-price','price','image','razmer', 'razmer2', 'cvet', 'sostav', 'Strana','Proizvoditel', 'Kornevai']
	
			writer << headers
			@marcs.each do |pr|
				sku = pr.sku
				title = pr.title
				sdesc = pr.sdesc
				desc = pr.desc
				qt = pr.qt
				cprice = pr.cprice
				price = pr.price
				image = pr.image
				if pr.razmer == 'Free'
				razmer = 'uni'
				else
				razmer = pr.razmer
				end
				razmer2 = pr.razmer2
				cvet = pr.cvet
				sostav = pr.sostav
				
				writer << [sku, title, sdesc, desc, qt, cprice, price, image, razmer, razmer2, cvet, sostav,'Франция', "Marc & André", "MarcAndre" ]
				end 
			end #CSV.open    
			
# 			CleoMailer.insales.deliver_now
		puts "Finish Файл Marc инсалес"
	end

	def self.open_spreadsheet(file)
	    case File.extname(file.original_filename)
	    when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "windows-1251:utf-8", col_sep: ";", liberal_parsing: true})
	    when ".xls" then Roo::Excel.new(file.path)
	    when ".xlsx" then Roo::Excelx.new(file.path)
	    when ".XLS" then Roo::Excel.new(file.path)
	    else raise "Unknown file type: #{file.original_filename}"
	    end
	end
	
	def update_desc
		if desc.present?
			new_desc = desc.split(' ').join(' ')
# 			update_attribute(:desc, self.desc)
			self.desc = new_desc
			puts new_desc
		end
	end
	
end
