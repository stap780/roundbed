class Best < ActiveRecord::Base
	validates :sku, uniqueness: true
	
	def self.download_old
		puts "start download Best - ""#{Time.now}"
		hrefs = ["https://best-sleep-shop.ru/catalog/matrasy/?pageSize=120&p=1","https://best-sleep-shop.ru/catalog/matrasy/?pageSize=120&p=2","https://best-sleep-shop.ru/catalog/ortopedicheskie-podushki/?pageSize=120","https://best-sleep-shop.ru/catalog/aksessuary-dlya-sna/?pageSize=120"]
# 		hrefs = ["https://best-sleep-shop.ru/catalog/ortopedicheskie-podushki/"]
		hrefs.each do |href|
			doc = Nokogiri::HTML(open(href, :read_timeout => 240))
			products_link = doc.css(".catalog-table .product_item_block > a")
			products_link.each do |pr_link|
			
				puts "https://best-sleep-shop.ru"+pr_link['href']
			
				pr_doc = Nokogiri::HTML(open("https://best-sleep-shop.ru"+pr_link['href'], :read_timeout => 240))
				title = pr_doc.css('.prod_name').text.strip if pr_doc.css('.prod_name') != nil
				puts title
				sdesc = pr_doc.css('.short_decription').text.strip if pr_doc.css('.short_decription') != nil
				desc = pr_doc.css('#tab-description article').inner_html if pr_doc.css('#tab-description article') != nil
				option_selects = pr_doc.css('.product-offers_item select')
# 			puts option_selects.present?			
				qt = 10
				pict_site = pr_doc.css('.rs-gallery-full a')
				picts = []
				pict_site.each do |p|
					picts.push('https://best-sleep-shop.ru'+p['href'])
				end
				image = picts.to_s.gsub('"','').gsub('[','').gsub(']','').gsub(',','')
				param_table = pr_doc.css('.tab-content_table_character tbody').last
				@p_razmer = ''
				@p_napolnit = ''
				@p_visota = ''
				@p_dlina = ''
				@p_shirina = ''
				@p_ves = ''
				@p_sostav = ''
				@p_osoben = ''
				@p_tipmatrasa = ''
				@p_garant = ''
				@p_forma = ''
				param_table.css('tr').each do |t|
					if t.css('td span')[0].text.gsub(' ','') == 'Размеры(см)'
					@p_razmer = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Наполнитель'
					@p_napolnit = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Высота(см)'
					@p_visota = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Длинна(см)'
					@p_dlina = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Ширина(см.)'
					@p_shirina = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Рекомендованныйвес'
					@p_ves = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Состав'
					@p_sostav = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Особенности'
					@p_osoben = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Типматраса'
					@p_tipmatrasa = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Гарантия(мес.)'
					@p_garant = t.css('td span')[1].text
					end
					if t.css('td span')[0].text.gsub(' ','') == 'Форма'
					@p_forma = t.css('td span')[1].text
					end
				end

				if !option_selects.present?
					cprice = pr_doc.css('.rs-price-old').text.gsub(' ','').gsub('.р','') if pr_doc.css('.rs-price-old') != nil
					price = pr_doc.css('.rs-price-new').text.gsub(' ','').gsub('.р','') if pr_doc.css('.rs-price-new') != nil
					sku = title.gsub(' ','-')
					best = Best.find_by_sku(sku)
					if best.present?
					best.update_attributes(:title => title, :sdesc => sdesc, :desc => desc, :cprice => cprice, :price => price, :qt => qt, :image => image, :p_razmer => @p_razmer, :p_napolnit => @p_napolnit, :p_visota => @p_visota, :p_dlina => @p_dlina, :p_shirina => @p_shirina, :p_ves => @p_ves, :p_sostav => @p_sostav, :p_osoben => @p_osoben, :p_tipmatrasa => @p_tipmatrasa, :p_garant => @p_garant, :p_forma => @p_forma)
					else
					Best.create(:sku => sku, :title => title, :sdesc => sdesc, :desc => desc, :cprice => cprice, :price => price, :qt => qt, :image => image, :p_razmer => @p_razmer, :p_napolnit => @p_napolnit, :p_visota => @p_visota, :p_dlina => @p_dlina, :p_shirina => @p_shirina, :p_ves => @p_ves, :p_sostav => @p_sostav, :p_osoben => @p_osoben, :p_tipmatrasa => @p_tipmatrasa, :p_garant => @p_garant, :p_forma => @p_forma)
					end
				end
				if option_selects.count == 1
					sv_razmer_all = pr_doc.css('.product-offers_item select option')
					if sv_razmer_all.present?
						sv_razmer_all.each_with_index do |sv, i|
							values = pr_doc.css('.hidden_offers')[i]['data-change-cost']
							sv_razmer = sv.text
							sku = values.gsub(/\"/,'').split(',')[0].split(':').last.gsub(' ','')
							if values.gsub(/\"/,'').split(',')[1].split(':').last.gsub(' ','') != 'нетцены'
							price = values.gsub(/\"/,'').split(',')[1].split(':').last.gsub(' ','')
							else
							price = 0
							end
							if values.gsub(/\"/,'').split(',')[2].split(':').last.gsub(' ','') != 'нетцены'
							cprice = values.gsub(/\"/,'').split(',')[2].split(':').last.gsub(' ','')
							else
							cprice = 0
							end
	
							best = Best.find_by_sku(sku)
							if best.present?
							best.update_attributes(:title => title, :sdesc => sdesc, :desc => desc, :cprice => cprice, :price => price, :qt => qt, :image => image, :sv_razmer => sv_razmer, :p_razmer => @p_razmer, :p_napolnit => @p_napolnit, :p_visota => @p_visota, :p_dlina => @p_dlina, :p_shirina => @p_shirina, :p_ves => @p_ves, :p_sostav => @p_sostav, :p_osoben => @p_osoben, :p_tipmatrasa => @p_tipmatrasa, :p_garant => @p_garant, :p_forma => @p_forma)
							else
							Best.create(:sku => sku, :title => title, :sdesc => sdesc, :desc => desc, :cprice => cprice, :price => price, :qt => qt, :image => image, :sv_razmer => sv_razmer, :p_razmer => @p_razmer, :p_napolnit => @p_napolnit, :p_visota => @p_visota, :p_dlina => @p_dlina, :p_shirina => @p_shirina, :p_ves => @p_ves, :p_sostav => @p_sostav, :p_osoben => @p_osoben, :p_tipmatrasa => @p_tipmatrasa, :p_garant => @p_garant, :p_forma => @p_forma)
							end
						end
					else
						sku = title.gsub(' ','-')
						sv_razmer = ''
						puts sku
						best = Best.find_by_sku(sku)
						if best.present?
						best.update_attributes(:title => title, :sdesc => sdesc, :desc => desc, :cprice => cprice, :price => price, :qt => qt, :image => image, :sv_razmer => sv_razmer, :p_razmer => @p_razmer, :p_napolnit => @p_napolnit, :p_visota => @p_visota, :p_dlina => @p_dlina, :p_shirina => @p_shirina, :p_ves => @p_ves, :p_sostav => @p_sostav, :p_osoben => @p_osoben, :p_tipmatrasa => @p_tipmatrasa, :p_garant => @p_garant, :p_forma => @p_forma)
						else
						Best.create(:sku => sku, :title => title, :sdesc => sdesc, :desc => desc, :cprice => cprice, :price => price, :qt => qt, :image => image, :sv_razmer => sv_razmer, :p_razmer => @p_razmer, :p_napolnit => @p_napolnit, :p_visota => @p_visota, :p_dlina => @p_dlina, :p_shirina => @p_shirina, :p_ves => @p_ves, :p_sostav => @p_sostav, :p_osoben => @p_osoben, :p_tipmatrasa => @p_tipmatrasa, :p_garant => @p_garant, :p_forma => @p_forma)
						end
					end
				end
				if option_selects.count > 1
					sv_razmer_all = pr_doc.css('.product-offers_item [data-prop-title="Размеры"] option')
					sv_chehol_all = pr_doc.css('.product-offers_item [data-prop-title="Выбор чехла"] option')
					sv_chehol_all.each do |chehol|
						sv_chehol = chehol.text
# 						puts "Чехол - "+sv_chehol
						sv_razmer_all.each_with_index do |sv, i|
							sv_razmer = sv.text
# 							puts "Размер - "+sv_razmer
							check_data = '[["Размеры", "'+sv_razmer+'"], ["Выбор чехла", "'+sv_chehol+'"]]'
# 							puts "Здесь check_data - "+check_data
							values_input = pr_doc.css('.hidden_offers')
							values_input.each do |v|
# 								puts "Здесь данные data-info -"+v['data-info']+"finish"
# 								puts v['data-info'].to_s.split(',')
# 								puts "Здесь кол-во split - "+v['data-info'].to_s.split(',').count.to_s
								if v['data-info'].to_s.split(',').count > 1
									data = JSON.parse(v['data-info'])
# 									puts "Здесь data.to_s - "+data.to_s
# 									puts "Здесь равны ли данные"
# 									puts data.to_s == check_data
									if data.to_s == check_data
										values = v['data-change-cost']
										sku = values.gsub(/\"/,'').split(',')[0].split(':').last.gsub(' ','')
										if values.gsub(/\"/,'').split(',')[1].split(':').last.gsub(' ','') != 'нетцены'
										price = values.gsub(/\"/,'').split(',')[1].split(':').last.gsub(' ','')
										else
										price = 0
										end
										if values.gsub(/\"/,'').split(',')[2].split(':').last.gsub(' ','') != 'нетцены'
										cprice = values.gsub(/\"/,'').split(',')[2].split(':').last.gsub(' ','')
										else
										cprice = 0
										end
				
										best = Best.find_by_sku(sku)
										if best.present?
										best.update_attributes(:title => title, :sdesc => sdesc, :desc => desc, :cprice => cprice, :price => price, :qt => qt, :image => image, :sv_razmer => sv_razmer, :sv_chehol => sv_chehol, :p_razmer => @p_razmer, :p_napolnit => @p_napolnit, :p_visota => @p_visota, :p_dlina => @p_dlina, :p_shirina => @p_shirina, :p_ves => @p_ves, :p_sostav => @p_sostav, :p_osoben => @p_osoben, :p_tipmatrasa => @p_tipmatrasa, :p_garant => @p_garant, :p_forma => @p_forma)
										else
										Best.create(:sku => sku, :title => title, :sdesc => sdesc, :desc => desc, :cprice => cprice, :price => price, :qt => qt, :image => image, :sv_razmer => sv_razmer, :sv_chehol => sv_chehol, :p_razmer => @p_razmer, :p_napolnit => @p_napolnit, :p_visota => @p_visota, :p_dlina => @p_dlina, :p_shirina => @p_shirina, :p_ves => @p_ves, :p_sostav => @p_sostav, :p_osoben => @p_osoben, :p_tipmatrasa => @p_tipmatrasa, :p_garant => @p_garant, :p_forma => @p_forma)
										end
									end
								end
							end
						end
					end
				end
				
			end
		end
		
		bests = Best.all.order(:id)
		bests.each do |best|
			best.cprice = best.price.to_i - best.price.to_i*30/100
			best.save
		end
		puts "finish download Best - ""#{Time.now}"
	end
	
	def self.insales_to_csv
		puts "Файл Best инсалес - ""#{Time.now}"
		
			file_ins = "#{Rails.public_path}"+'/insales_best.csv'
			check = File.file?(file_ins)
			if check.present?
				File.delete(file_ins)
			end
			
			@bests = Best.where.not(price: nil).order(:id)#.limit(2)
			file = "#{Rails.root}/public/insales_best.csv"
			CSV.open( file, 'w') do |writer|
			headers = ['Артикул', 'Название товара', 'Краткое описание', 'Полное описание', 'Цена закупки', 'Цена продажи', 'Колличество', 'Изображения', 'sv_razmer', 'sv_chehol', 'p_razmer', 'p_napolnit', 'Свойство: Высота', 'Свойство: Длина', 'Свойство: Ширина', 'p_ves', 'p_sostav', 'Свойство: Цвет', 'p_tipmatrasa', 'p_garant', 'p_forma', 'Параметр: Производитель', 'Kornevai']
	
			writer << headers
			@bests.each do |pr|
				sku = pr.sku
				title = pr.title
				sdesc = pr.sdesc
				desc = pr.desc
				cprice = pr.cprice
				price = pr.price
				qt = pr.qt
				image = pr.image
				sv_razmer = pr.sv_razmer
				sv_chehol = pr.sv_chehol
				p_razmer = pr.p_razmer
				p_napolnit = pr.p_napolnit
				p_visota = pr.p_visota
				p_dlina = pr.p_dlina
				p_shirina = pr.p_shirina
				p_ves = pr.p_ves
				p_sostav = pr.p_sostav
				p_osoben = pr.p_osoben
				p_tipmatrasa = pr.p_tipmatrasa
				p_garant = pr.p_garant
				p_forma = pr.p_forma
				
				writer << [sku, title, sdesc, desc, cprice, price, qt, image, sv_razmer, sv_chehol, p_razmer, p_napolnit, p_visota, p_dlina, p_shirina, p_ves, p_sostav, p_osoben, p_tipmatrasa, p_garant, p_forma, "BestSleep", "Best" ]
				end 
			end #CSV.open    
			
		BestMailer.insales.deliver_now
		puts "Finish Файл Best инсалес - ""#{Time.now}"		
	end

	def self.download
		puts "start download Best - ""#{Time.now}"
		productbefore = Best.count
		Best.update_all(qt: 0)
		
		hrefs = ["https://www.best-sleep.ru/catalogue/mattresses","https://www.best-sleep.ru/catalogue/toppers","https://www.best-sleep.ru/catalogue/pillows"] #"https://best-sleep-shop.ru/catalog/aksessuary-dlya-sna/?pageSize=120"
		hrefs.each do |href|
			doc = Nokogiri::HTML(open(href, :read_timeout => 240))
			pages_max_size = (doc.css('.pagination')[0]['data-qty'].to_f/doc.css('.pagination')[0]['data-onpage'].to_f).ceil  #doc.css('.page-link').last.text
			pages = Array(1..pages_max_size.to_i)
			pages.each do |page|
			cat_doc = Nokogiri::HTML(open(href+"?page="+page.to_s, :read_timeout => 240))
			products = cat_doc.css(".prod-prev")
			if products.size > 0
				products.each do |pr|
			
				pr_link = "https://www.best-sleep.ru"+pr.css('.prod-prev-more')[0]['href']
			
				pr_doc = Nokogiri::HTML(open(pr_link, :read_timeout => 240))
				title = pr_doc.css('h1.prod-title').text.strip
				puts title
				sdesc = pr.css('.prod-prev-desc').text.split(' ').join(' ') if pr.css('.prod-prev-desc') != nil
				desc1 = pr_doc.css('.prod-info-wrap .prod-opt-cont .prod-desc').text.strip
				desc2 = 'Характеристики: '+pr_doc.css('.prod-info-wrap .prod-adv .prod-adv-item').map{|v| '<li>'+v.text.split(' ').join(' ')+'</li>'}.join
				desc3 = 'Особенности: '+pr_doc.css('.prod-opt-cont .prod-img-functions-item').map{|v| '<li>'+v.text.split(' ').join(' ')+'</li>'}.join
				desc4 = 'Материалы: '+pr_doc.css('.prod-opt-cont .prod-img-materials-item').map{|v| '<li>'+v.text.split(' ').join(' ')+'</li>'}.join
				desc = desc1+'<p>'+desc2+'</p><p>'+desc3+'</p><p>'+desc4+'</p>'
				
				image = "https://www.best-sleep.ru"+pr_doc.css('.prod-main-img img')[0]['src']
				
				qt = 10
				razmer = pr_doc.css('[data-val="item-size"]')[0]
				razmer_array = razmer.css('option').present? ? razmer.css('option').map{|r| r['value']} : [""]
				visota = pr_doc.css('[data-val="item-height"]')[0]
				visota_array = visota.css('option').present? ? visota.css('option').map{|r| r['value']} : [""]
				var_array1 = razmer_array.cartesian_product(visota_array).to_a
				osoben_array = pr_doc.css('.prod-colors .prod-prev-mat-name').present? ? pr_doc.css('.prod-colors .prod-prev-mat-name').map{|p| p.text} : ['']
				var_array2 = var_array1.cartesian_product(osoben_array).to_a
	
				variants = var_array2.compact.map{|va| va.flatten}
				puts variants.count
				variants.each do |variant|
					width = variant[0].split(",")[0].to_s
					length = variant[0].split(",")[1].to_s
					height = variant[1].to_s
					cvet = variant[2].to_s
					first_var_id = pr_doc.css('.product-wrap')[0]['data-id']
# 					cat_id = pr_doc.css('.product-wrap')[0]['cat-id']
# 					cat = pr_doc.css('.product-wrap')[0]['data-cat']
					sku = first_var_id.to_s+"-"+width+"-"+length+"-"+height+"-"+cvet
# 					price = nil
# 					cprice = nil
				
					data = { 
							sku: sku,
							title: title,
							sdesc: sdesc,
							desc: desc,
							#cprice: cprice,
							#price: price,
							qt: qt,
							image: image,
							sv_razmer: "",
							sv_chehol: "",
							p_razmer: "",
							p_napolnit: "",
							p_visota: height,
							p_dlina: length,
							p_shirina: width,
							p_ves: "",
							p_sostav: "",
							p_osoben: cvet,
							p_tipmatrasa: "",
							p_garant: "",
							p_forma: first_var_id
						}
					
					Best.create_update_by_sku(data)
				end
				end
			end
			end
		end
		
		productafter = Best.count
		BestMailer.download(productbefore, productafter).deliver_now
		puts "finish download Best - ""#{Time.now}"
	end
	
	def self.create_update_by_sku(data)
		puts 'start create_update_by_fid '+Time.now.to_s
# 		puts data.to_s
# 		puts data[:sku]
			best = Best.find_by_sku(data[:sku])
			if best.present?
				puts "товар есть и обновляем"
				best.update_attributes(data)
			else
				puts "товар нет и создаём"
				Best.create(data)
			end			
		puts 'finish create_update_by_fid '+Time.now.to_s 	
	end
	
	def self.update_price
		puts "start update_price Best - ""#{Time.now}"
		bests = Best.where(price: nil).order(:id)
		bests.each do |best|
			first_var_id = best.p_forma.to_s
			width = best.p_shirina.to_s
			length = best.p_dlina.to_s
			height = best.p_visota.to_s
			
			json_url = "https://www.best-sleep.ru/ajax/get_item.php?id="+first_var_id.to_s+"&height="+height+"&width="+width+"&length="+length
			puts json_url
			response = RestClient.get( json_url, :open_timeout => 240)
			get_data = JSON.parse(response.body)
			get_data_id = get_data['id']
			price = get_data['price']
			cprice = price.to_i - price.to_i*30/100
			
			best.update_attributes(price: price, cprice: cprice)
		end
		
		BestMailer.insales.deliver_now
		puts "finish update_price Best - ""#{Time.now}"
	end


end
