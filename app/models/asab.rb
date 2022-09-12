class Asab < ActiveRecord::Base

	require 'roo'
	require 'roo-xls'

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			sku = spreadsheet.cell(i,'A').to_s.strip if spreadsheet.cell(i,'A').present?
			puts "Артикул -"+sku.to_s
			sdesc = spreadsheet.cell(i,'B').to_s.strip if spreadsheet.cell(i,'B').present?
			sostav = spreadsheet.cell(i,'C').to_s.strip if spreadsheet.cell(i,'C').present?
			cprice = spreadsheet.cell(i,'D').to_s.strip if spreadsheet.cell(i,'D').present?
			price = spreadsheet.cell(i,'E').to_s.strip if spreadsheet.cell(i,'E').present?
			qt = spreadsheet.cell(i,'F').to_s.strip if spreadsheet.cell(i,'F').present?
				asab = Asab.find_by_sku(sku)
				if asab.present?
				asab.update_attributes(:sdesc => sdesc, :sostav => sostav, :cprice => cprice, :price => price, :qt => qt)
				else
				Asab.create(:sku => sku, :sdesc => sdesc, :sostav => sostav, :cprice => cprice, :price => price, :qt => qt)
				end
		end
	end

	def self.download
		pr_ids = (12..4600).to_a
		pr_ids.each do |pr_id|
		puts pr_id.to_s
		href = "http://asabella-life.ru/index.php?route=product/product&product_id="+pr_id.to_s
		RestClient.get( href) { |response, request, result, &block|
				case response.code
				when 200
					pr_doc = Nokogiri::HTML(response)
		# 			desc = pr_doc.css('[id="product-full-desc"]').inner_html
					title = pr_doc.css("h1").text
					desc = pr_doc.css("#tab-description").inner_html.strip
					sku_file = title.split(' ').last
					puts "Артикул -"+sku_file

					check = CLD.detect_language(sku_file)
					puts check[:code]
					if check[:code] == 'ru'
						ru_letters = ["А", "Б", "В", "Г","Д","Е","Ё","Ж","З","И","Й","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ы","Ъ","Ь","Э","Ю","Я"]
						ru_letters_hash = {"А"=>"A", "Б"=>"B", "В"=>"B", "Е"=>"E","К"=>"K","М"=>"M","Н"=>"H","О"=>"O","Р"=>"P","С"=>"C","Т"=>"T","У"=>"Y","Х"=>"X"}
						new_sku_array = []
						sku_file.each_char do |c|
			# 				puts c
							if ru_letters.include?(c)
								new_c = ru_letters_hash[c]
								new_sku_array.push(new_c)
							else
								new_sku_array.push(c)
							end
						end
						sku = new_sku_array.join('')
					else
						sku = sku_file
					end

					aid = pr_id
					pict_site = pr_doc.css('.imgthumb').present? ? pr_doc.css('.imgthumb a').map{|im| URI.encode(im['href']) if im['href'] != "javascript:void(0)" && !im['href'].include?("no_image") }.uniq : []
					pict = pict_site.join(' ')
					asab = Asab.find_by_sku(sku)
					if asab.present?
					asab.update_attributes(:aid => aid, :title => title, :desc => desc, :image => pict)
					else
					Asab.create(:sku => sku, :aid => aid, :title => title, :desc => desc, :image => pict)
					end
				when 404
					puts 'error 404'
					break
				else
					response.return!(&block)
				end
				}
		end
	end


	def self.insales_to_csv
		puts "Файл Asab инсалес"

			file_ins = "#{Rails.public_path}"+'/insales_asab1.csv'
			check = File.file?(file_ins)
			if check.present?
				File.delete(file_ins)
			end

			@asabs = Asab.where.not(:aid=> nil).order(:id)#.limit(2)
			file = "#{Rails.root}/public/insales_asab1.csv"
			CSV.open( file, 'w') do |writer|
			headers = ['sku', 'title', 'sdesc', 'desc', 'quantity', 'cost-price','price','image', 'sostav', 'Strana','Proizvoditel', 'Kornevai']

			writer << headers
			@asabs.each do |pr|
				sku = pr.sku
				title = pr.title
				sdesc = pr.sdesc
				desc = pr.desc
				qt = pr.qt
				cprice = pr.cprice
				price = pr.price
				image = pr.image
				sostav = pr.sostav

				writer << [sku, title, sdesc, desc, qt, cprice, price, image, sostav,'Италия', "Asabella", "Asabella" ]
				end
			end #CSV.open

# 			CleoMailer.insales.deliver_now
		puts "Finish Файл Asab инсалес"
	end

	def self.open_spreadsheet(file)
# 		puts file.original_filename
		if !file.is_a?String
		    case File.extname(file.original_filename)
		    when ".csv" then Roo::CSV.new(file.path, csv_options: { col_sep: ";"})
		    when ".xls" then Roo::Excel.new(file.path)
		    when ".xlsx" then Roo::Excelx.new(file.path, password: '495')
		    when ".XLS" then Roo::Excel.new(file.path)
		    else raise "Unknown file type: #{file.original_filename}"
		    end
	    else
		    Roo::Excelx.new(file, password: 495 )
	    end
	end


end
