class Cleo < ActiveRecord::Base
	
	validates :sku, uniqueness: true
	
	
	def self.download
		puts "start Cleo download"
		productbefore = Cleo.count
		
		urls = ['http://cleo-opt.ru/data/1c/CSV3.csv','http://cleo-opt.ru/data/1c/CSV2.csv']
		product_full_url = urls[0]
		product_qt_url = urls[1]
		## Загружаем номенклатуру
		product_full_url = urls[0]
		download_path1 = "#{Rails.public_path}"+"/cleo1.csv"
		download1 = open(product_full_url)
		IO.copy_stream(download1, download_path1)
		file1 = download_path1
		Cleo.import(file1)
		
		## Обновляем остатки
		download_path2 = "#{Rails.public_path}"+"/cleo2.csv"
		download2 = open(product_qt_url)
		IO.copy_stream(download2, download_path2)
		file2 = download_path2
		Cleo.update_all(qt: 0)
		spreadsheet = open_spreadsheet(file2)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			sku = row["Артикул"].to_s.strip
			qt = row["Свободный остаток"].to_s.strip
			cprice = row["Оптовая"].to_s.strip
			price = cprice.to_i*1.5
			cleo = Cleo.find_by_sku(sku)
			if cleo.present?
				cleo.update_attributes( cprice: cprice, price: price, qt: qt)
			end
		end
		
		productafter = Cleo.count
		CleoMailer.download(productbefore, productafter).deliver_now
		puts "finish Cleo download"

	end

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
		     
			row = Hash[[header, spreadsheet.row(i)].transpose]
	# 		puts row.inspect
	
			sku = row["Артикул"].to_s.strip
			title = row["Наименование товара"].to_s.strip
			sdesc = row["Описание"].to_s.strip
			desc = row["Описание"].to_s.strip
	# 		cprice = row["Описание"].to_s.strip
	# 		price = row["Цена"] #.to_s.strip
	# 		qt = row["Количество"].to_s.strip
			image = row["Изображение"].to_s.strip
			barcode = row["Штрихкод"].to_s.strip
			dizain = row["Дизайн"].to_s.strip
			cvet = row["Цвет"].to_s.strip
			tema = row["Тематика"].to_s.strip
			okras = row["Окрашивание"].to_s.strip
			otdelka = row["Отделка"].to_s.strip 
			zast = row["Застежка"].to_s.strip 
			kvopred = row["Кол-во предметов в наборе"].to_s.strip 
			tkan = row["Ткань"].to_s.strip 
			plotnost = row["Плотность"].to_s.strip 
			sostav = row["Состав"].to_s.strip
			obrazmer = row["Общий размер"].to_s.strip
			pr_razmer = row["Размеры"].to_s.strip
			obem = row["Объем (м3)"].to_s.strip
			ves = row["Вес (кг)"].to_s.strip
			razmer_upak = row["Размер упаковки"].to_s.strip
			vid_upak = row["Вид упаковки"].to_s.strip
			
			
			cleo = Cleo.find_by_sku(sku)
			if cleo.present?
				cleo.update_attributes( title: title, sdesc: sdesc, desc: desc, image: image, barcode: barcode, dizain: dizain, cvet: cvet, tema: tema, okras: okras, otdelka: otdelka, zast: zast, kvopred: kvopred, tkan: tkan, plotnost: plotnost, sostav: sostav, obrazmer: obrazmer, pr_razmer: pr_razmer, obem: obem, ves: ves, razmer_upak: razmer_upak, vid_upak: vid_upak)
			else
				Cleo.create(sku: sku, title: title, sdesc: sdesc, desc: desc, image: image, barcode: barcode, dizain: dizain, cvet: cvet, tema: tema, okras: okras, otdelka: otdelka, zast: zast, kvopred: kvopred, tkan: tkan, plotnost: plotnost, sostav: sostav, obrazmer: obrazmer, pr_razmer: pr_razmer, obem: obem, ves: ves, razmer_upak: razmer_upak, vid_upak: vid_upak)
			end
			
		end	
	end

	def self.insales_to_csv
		puts "Файл Cleo инсалес"
		
			file_ins = "#{Rails.public_path}"+'/insales_cleo.csv'
			check = File.file?(file_ins)
			if check.present?
				File.delete(file_ins)
			end
			
			@cleos = Cleo.all.order(:id)#.limit(2)
			file = "#{Rails.root}/public/insales_cleo.csv"
			CSV.open( file, 'w') do |writer|
			headers = ['sku', 'title', 'sdesc', 'desc', 'quantity', 'cost-price','price','image','barcode', 'dizain', 'cvet', 'tema', 'okras', 'otdelka', 'zast', 'kvopred', 'tkan', 'plotnost', 'sostav', 'obrazmer', 'pr_razmer', 'obem', 'ves', 'razmer_upak', 'vid_upak','Proizvoditel', 'Kornevai']
	
			writer << headers
			@cleos.each do |pr|
				sku = pr.sku
				title = pr.title
				sdesc = pr.sdesc
				desc = pr.desc
				qt = pr.qt
				cprice = pr.cprice
				price = pr.price
				image = pr.image
				barcode = pr.barcode
				dizain = pr.dizain
				cvet = pr.cvet
				tema = pr.tema
				okras = pr.okras
				otdelka = pr.otdelka
				zast = pr.zast
				kvopred = pr.kvopred
				tkan = pr.tkan
				plotnost = pr.plotnost
				sostav = pr.sostav
				obrazmer = pr.obrazmer
				pr_razmer = pr.pr_razmer
				obem = pr.obem
				ves = pr.ves
				razmer_upak = pr.razmer_upak
				vid_upak = pr.vid_upak
				
				writer << [sku, title, sdesc, desc, qt, cprice, price, image, barcode, dizain, cvet, tema, okras, otdelka, zast, kvopred, tkan, plotnost, sostav, obrazmer, pr_razmer, obem, ves, razmer_upak, vid_upak, 'Cleo', 'Cleo' ]
				end 
			end #CSV.open    
			
			CleoMailer.insales.deliver_now
		puts "Finish Файл Cleo инсалес"
	end

	def self.open_spreadsheet(file)
# 		puts file.original_filename
		if !file.is_a?String
		    case File.extname(file.original_filename)
		    when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "windows-1251:utf-8", col_sep: ";", liberal_parsing: true})
		    when ".xls" then Roo::Excel.new(file.path)
		    when ".xlsx" then Roo::Excelx.new(file.path)
		    when ".XLS" then Roo::Excel.new(file.path)
		    else raise "Unknown file type: #{file.original_filename}"
		    end
	    else
	    	Roo::CSV.new(file, csv_options: {encoding: "windows-1251:utf-8", col_sep: ";", liberal_parsing: true})
	    end
	end


end
