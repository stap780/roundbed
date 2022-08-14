class Alvitek < ActiveRecord::Base
	
def self.download

end

def self.import(file)
	spreadsheet = open_spreadsheet(file)
	header = spreadsheet.row(1)
	(2..spreadsheet.last_row).each do |i|
	     
		row = Hash[[header, spreadsheet.row(i)].transpose]
# 		puts row.inspect
		sku = row["Артикул"].to_s.strip
		title = row["Номенклатура"].to_s.strip
		desc = row["Описание"].to_s.strip
		qt = row["Количество"].to_s.strip
		price = row["Цена"] #.to_s.strip
		mprice_file = row["МРРЦ"] #.to_s.strip
# 		puts mprice_file.to_i
# 		if mprice_file.to_i == 0
		mprice = price.to_i*1.5
# 		else
# 		mprice = mprice_file
# 		end
		image = row["Фото"].to_s.strip 
		cat = row["Категория товара"].to_s.strip 
		col = row["Коллекция"].to_s.strip 
		vendor = row["Бренд"].to_s.strip 
		country = row["Страна производства"].to_s.strip 
		line = row["Линейка"].to_s.strip 
		razmer = row["Размер"].to_s.strip
# 		puts razmer
		teplota = row["Степень теплоты"].to_s.strip 
		podderjka = row["Степень поддержки"].to_s.strip 
		razm_nav = row["Размер наволочек"].to_s.strip 
		razm_podod = row["Размер пододеяльника"].to_s.strip 
		razmer_prostini = row["Размер простыни"].to_s.strip 
		tip_prostini = row["Тип простыни"].to_s.strip 
		visota = row["Высота"].to_s.strip 
		napolnitel = row["Наполнитель"].to_s.strip 
		napolnitel_chehla = row["Наполнитель чехла"].to_s.strip 
		napolnitel_yadra = row["Наполнитель ядра"].to_s.strip 
		ves_napolnitel = row["Вес наполнителя"].to_s.strip 
		ves_nopolnitel_chehla = row["Вес наполнителя чехла"].to_s.strip 
		ves_napolnitel_yadra = row["Вес наполнителя ядра"].to_s.strip 
		tkan = row["Ткань"].to_s.strip 
		sostav_tkan = row["Состав ткани"].to_s.strip 
		tip_zast = row["Тип застежки"].to_s.strip 
		tip_zast_navol = row["Тип застежки наволочки"].to_s.strip 
		tip_zast_podod = row["Тип застежки пододеяльника"].to_s.strip 
		tip_krepl = row["Тип крепления"].to_s.strip 
		tip_stejki = row["Тип стежки"].to_s.strip 
		okantovka = row["Окантовка"].to_s.strip 
		upak = row["Упаковка"].to_s.strip 
		tip_upak = row["Тип упаковки"].to_s.strip 
		kol_upak = row["Количество в упаковке"].to_s.strip 
		material = row["Материал"].to_s.strip 
		plotnost = row["Плотность"].to_s.strip 
		barcode = row["ШтрихКод"].to_s.strip 
		cvet = row["Цвет"].to_s.strip 
		tkan_verh = row["Ткань верха"].to_s.strip 
		tkan_niz = row["Ткань низ"].to_s.strip 
		sostav = row["Состав"].to_s.strip
		
		alvitek = Alvitek.find_by_sku(sku)
		if alvitek.present?
			alvitek.update_attributes(title: title, desc: desc, qt: qt, price: price, mprice: mprice, image: image, cat: cat, col: col, vendor: vendor, country: country, line: line, razmer: razmer, teplota: teplota, podderjka: podderjka, razm_nav: razm_nav, razm_podod: razm_podod, razmer_prostini: razmer_prostini, tip_prostini: tip_prostini, visota: visota, napolnitel: napolnitel, napolnitel_chehla: napolnitel_chehla, napolnitel_yadra: napolnitel_yadra, ves_napolnitel: ves_napolnitel, ves_nopolnitel_chehla: ves_nopolnitel_chehla, ves_napolnitel_yadra: ves_napolnitel_yadra, tkan: tkan, sostav_tkan: sostav_tkan, tip_zast: tip_zast, tip_zast_navol: tip_zast_navol, tip_zast_podod: tip_zast_podod, tip_krepl: tip_krepl, tip_stejki: tip_stejki, okantovka: okantovka, upak: upak, tip_upak: tip_upak, kol_upak: kol_upak, material: material, plotnost: plotnost, barcode: barcode, cvet: cvet, tkan_verh: tkan_verh, tkan_niz: tkan_niz, sostav: sostav)
		else
			Alvitek.create(sku: sku, title: title, desc: desc, qt: qt, price: price, mprice: mprice, image: image, cat: cat, col: col, vendor: vendor, country: country, line: line, razmer: razmer, teplota: teplota, podderjka: podderjka, razm_nav: razm_nav, razm_podod: razm_podod, razmer_prostini: razmer_prostini, tip_prostini: tip_prostini, visota: visota, napolnitel: napolnitel, napolnitel_chehla: napolnitel_chehla, napolnitel_yadra: napolnitel_yadra, ves_napolnitel: ves_napolnitel, ves_nopolnitel_chehla: ves_nopolnitel_chehla, ves_napolnitel_yadra: ves_napolnitel_yadra, tkan: tkan, sostav_tkan: sostav_tkan, tip_zast: tip_zast, tip_zast_navol: tip_zast_navol, tip_zast_podod: tip_zast_podod, tip_krepl: tip_krepl, tip_stejki: tip_stejki, okantovka: okantovka, upak: upak, tip_upak: tip_upak, kol_upak: kol_upak, material: material, plotnost: plotnost, barcode: barcode, cvet: cvet, tkan_verh: tkan_verh, tkan_niz: tkan_niz, sostav: sostav)
		end
		
	end	
end

def self.insales_to_csv
	puts "Файл Alvitek инсалес"
	
		file_ins = "#{Rails.public_path}"+'/insales_alvitek.csv'
		check = File.file?(file_ins)
		if check.present?
			File.delete(file_ins)
		end
		
		@alviteks = Alvitek.where.not('title like ?', '%Уценка%' ).order(:id)#.limit(2)
		file = "#{Rails.root}/public/insales_alvitek.csv"
		CSV.open( file, 'w') do |writer|
		headers = ['sku', 'title', 'desc', 'quantity', 'cost-price','price','image', 'col', 'vendor', 'country', 'line', 'SV_razmer', 'teplota', 'podderjka', 'razm_nav', 'razm_podod', 'razmer_prostini', 'tip_prostini', 'visota', 'napolnitel', 'napolnitel_chehla', 'napolnitel_yadra', 'ves_napolnitel', 'ves_nopolnitel_chehla', 'ves_napolnitel_yadra', 'tkan', 'sostav_tkan', 'tip_zast', 'tip_zast_navol', 'tip_zast_podod', 'tip_krepl', 'tip_stejki', 'okantovka', 'upak', 'tip_upak', 'kol_upak', 'material', 'plotnost', 'barcode', 'SV_cvet', 'tkan_verh', 'tkan_niz', 'sostav', 'Kornevai']

		writer << headers
		@alviteks.each do |pr|
			sku = pr.sku
			title = pr.title
			desc = pr.desc
			qt = pr.qt
			cprice = pr.price
			price = pr.mprice
			image = pr.image
			col = pr.col
			vendor = pr.vendor
			country = pr.country
			line = pr.line
			razmer = pr.razmer
			teplota = pr.teplota
			podderjka = pr.podderjka
			razm_nav = pr.razm_nav
			razm_podod = pr.razm_podod
			razmer_prostini = pr.razmer_prostini
			tip_prostini = pr.tip_prostini
			visota = pr.visota
			napolnitel = pr.napolnitel
			napolnitel_chehla = pr.napolnitel_chehla
			napolnitel_yadra = pr.napolnitel_yadra
			ves_napolnitel = pr.ves_napolnitel
			ves_nopolnitel_chehla = pr.ves_nopolnitel_chehla
			ves_napolnitel_yadra = pr.ves_napolnitel_yadra
			tkan = pr.tkan
			sostav_tkan = pr.sostav_tkan
			tip_zast = pr.tip_zast
			tip_zast_navol = pr.tip_zast_navol
			tip_zast_podod = pr.tip_zast_podod
			tip_krepl = pr.tip_krepl
			tip_stejki = pr.tip_stejki
			okantovka = pr.okantovka
			upak = pr.upak
			tip_upak = pr.tip_upak
			kol_upak = pr.kol_upak
			material = pr.material
			plotnost = pr.plotnost
			barcode = pr.barcode
			cvet = pr.cvet
			tkan_verh = pr.tkan_verh
			tkan_niz = pr.tkan_niz
			sostav = pr.sostav
			
			writer << [sku, title, desc, qt, cprice, price, image, col, vendor, country, line, razmer, teplota, podderjka, razm_nav, razm_podod, razmer_prostini, tip_prostini, visota, napolnitel, napolnitel_chehla, napolnitel_yadra, ves_napolnitel, ves_nopolnitel_chehla, ves_napolnitel_yadra, tkan, sostav_tkan, tip_zast, tip_zast_navol, tip_zast_podod, tip_krepl, tip_stejki, okantovka, upak, tip_upak, kol_upak, material, plotnost, barcode, cvet, tkan_verh, tkan_niz, sostav, 'Alvitek' ]
			end 
		end #CSV.open    
		
# 		EvatekMailer.insales.deliver_now
	puts "Finish Файл Alvitek инсалес"
end

def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "windows-1251:utf-8", col_sep: ";"})
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    when ".XLS" then Roo::Excel.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
end


end
