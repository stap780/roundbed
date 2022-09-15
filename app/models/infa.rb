class Infa < ActiveRecord::Base

	validates :fid, uniqueness: true

def self.download
	puts "download Infa "+"#{Time.zone.now}"
	productbefore = Infa.count
	uri = "http://www.infania.ru/yml_products.xml"

		download_path = "#{Rails.public_path}"+"/"+uri.split('/').last.split('.').first+"_Infa.xml"
		puts download_path
		#удаляем старый файл
		check = File.file?(download_path)
		if check.present?
			puts "file present"
			File.delete(download_path)
		end
		#сохраняем новый файл
		download = open(uri)
		IO.copy_stream(download, download_path)

# 	response = RestClient.get uri, :accept => :xml, :content_type => "application/xml"
    doc = File.open(download_path)
    data = Nokogiri::XML(doc, nil, "UTF-8")
    product = "yml_catalog/shop/offers/offer"
    mypr = data.xpath(product)
    cat = "yml_catalog/shop/categories/category"
    mycat = data.xpath(cat)
    Infa.update_all(:qt=>0)
    puts "set 0 qt"

		mypr.each do |pr|
			fid = pr["id"]
# 			puts fid
			#sku = pr.css("[name='Артикул']").text.strip
			sku = pr.xpath("vendorCode").text.strip
			title = pr.xpath("name").text.strip
			link = pr.xpath("url").text#.split('?')[0]
			price = pr.xpath("price").text.split('.')[0]
			costprice = price.to_f*0.5
			desc = pr.xpath("description").text.strip.gsub('Наведите курсор на иконку, чтобы узнать больше!','')
			feature = pr.xpath("features").text.strip.gsub('Наведите курсор на иконку, чтобы узнать больше!','')
			barcode = pr.xpath("barcode").text.strip
			vendor = pr.xpath("vendor").text.strip
			model = pr.xpath("model").text.strip
			quantity = pr.xpath("quantity").text.strip

			qt = quantity == ">10" ? "10" : quantity

			cat_id = pr.xpath("categoryId").text
			cat = "yml_catalog/shop/categories/category"
			mycat = data.xpath(cat)
			cats_array = []
			string = "[id='"+cat_id+"']"
			cats_array.push(mycat.css(string).text)
			if mycat.css(string).attr("parentId")
				cat_id2 = mycat.css(string).attr("parentId").text
				string2 = "[id='"+cat_id2+"']"
				cats_array.push(mycat.css(string2).text)
				if mycat.css(string2).attr("parentId")
					cat_id3 = mycat.css(string2).attr("parentId").text
					string3 = "[id='"+cat_id3+"']"
					cats_array.push(mycat.css(string3).text)
				end
			end
			cat = cats_array.to_s.gsub('"','').gsub('[','').gsub(']','').gsub(',','/')

			pict = []
			picts = pr.xpath("picture")
			picts.each do |pic|
				pict.push(pic.text)
			end
			image = pict.to_s.gsub('"','').gsub('[','').gsub(']','').gsub(',','')
			vparam_array = []
			vparams = pr.xpath("param")
			vparams.each do |v|
				vparam_string = v["name"]+":"+v.text
				vparam_array.push(vparam_string)
			end
			vparam = vparam_array.join('---')#.to_s.gsub('"','').gsub('[','').gsub(']','').gsub(',','---')

			if vendor == 'Lorena Canals'
				@infa = Infa.where("fid = ?", fid)
				if @infa.present?
					@infa.each do |p|
					p.update_attributes(:sku => sku, :barcode => barcode, :desc => desc, :feature => feature, :title=> title, :price=>price, :costprice => costprice, :qt=>qt, :image=>image, :cat=>cat, :i_param=>vparam, :model => model, :vendor => vendor )
					end
				else
					Infa.create(:fid => fid, :sku => sku, :barcode => barcode, :feature => feature, :desc => desc, :title=> title, :price=>price, :costprice => costprice, :qt=>qt, :image=>image, :cat=>cat, :i_param=>vparam, :model => model, :vendor => vendor )
				end

			end
	  	end

	productafter = Infa.count
# 	InfaMailer.download(productbefore, productafter).deliver_now
	puts "Finish download Infa"
end

def self.insales_to_csv
	puts "Файл Infa инсалес"
		file = "#{Rails.public_path}"+'/Infa.csv'
		check = File.file?(file)
		if check.present?
			File.delete(file)
		end
		file_ins = "#{Rails.public_path}"+'/insales_infa.csv'
		check = File.file?(file_ins)
		if check.present?
			File.delete(file_ins)
		end

		@infas = Infa.order(:id)#.limit(30)# where('title like ?', '%Bellelli B-bip%')
		file = "#{Rails.root}/public/Infa.csv"
		CSV.open( file, 'w') do |writer|
		headers = ['fid','Артикул', 'Название товара', 'Краткое описание', 'Полное описание', 'Цена закупки', 'Цена продажи', 'Остаток', 'Изображения', 'Вендор', 'Модель', 'Корневая']

		writer << headers
		@infas.each do |pr|
			if pr.title != nil
				puts pr.id
				fid = pr.fid
				title = pr.title.split(',')[0]
				sku = pr.sku
				image = pr.image
				price = pr.price
				costprice = pr.costprice
				qt = pr.qt
				desc = pr.desc + pr.feature
				if desc !=nil
				shortdesc = desc.split('.')[0]+'.'+desc.split('.')[1]
				else
				shortdesc = ''
				end
				vendor = pr.vendor
				model = pr.model
				writer << [fid, sku, title, shortdesc, desc, costprice, price, qt, image, vendor, model, 'Infa' ]
				end
			end
		end #CSV.open

		# дополняем header файла названиями параметров

		vparamHeader = []
		p = @infas.select(:i_param)
		p.each do |p|
			if p.i_param != nil
				p.i_param.split('---').each do |pa|
					vparamHeader << pa.split(':')[0] if pa != nil
				end
			end
		end
		addHeaders = vparamHeader.uniq

		# Load the original CSV file
		rows = CSV.read(file, headers: true).collect do |row|
			row.to_hash
		end

		# Original CSV column headers
		column_names = rows.first.keys
		# Array of the new column headers
		addHeaders.each do |addH|
		additional_column_names = ['Параметр: '+addH]
		# Append new column name(s)
		column_names += additional_column_names
			s = CSV.generate do |csv|
				csv << column_names
				rows.each do |row|
					# Original CSV values
					values = row.values
					# Array of the new column(s) of data to be appended to row
	# 				additional_values_for_row = ['1']
	# 				values += additional_values_for_row
					csv << values
				end
			end
		File.open(file, 'w') { |file| file.write(s) }
		end
		# Overwrite csv file

		# заполняем параметры по каждому товару в файле
		new_file = "#{Rails.public_path}"+'/insales_infa.csv'
		CSV.open(new_file, "w") do |csv_out|
			rows = CSV.read(file, headers: true).collect do |row|
				row.to_hash
			end
			column_names = rows.first.keys
			csv_out << column_names
			CSV.foreach(file, headers: true ) do |row|
			fid = row[0]
			vel = Infa.find_by_fid(fid)
				if vel != nil
# 				puts vel.id
					if vel.i_param.present? # Вид записи должен быть типа - "Длина рамы: 20 --- Ширина рамы: 30"
					vel.i_param.split('---').each do |vp|
						key = 'Параметр: '+vp.split(':')[0]
						value = vp.split(':')[1].remove('. ') if vp.split(':')[1] !=nil
						row[key] = value
					end
					end
				end
			csv_out << row
			end
		end
# 	InfaMailer.insales.deliver_now
	puts "Finish Файл Infa инсалес"
end


end
