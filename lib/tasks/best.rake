namespace :best do
  desc "Tasks for bestsleep"
  
	task download: :environment do
		puts "start download Best - ""#{Time.now}"
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
				
				desc = pr_doc.css('.prod-info-wrap').inner_html.gsub(title,'')+pr_doc.css('.left-part-bottom').inner_html
				
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
					sku = width+"-"+length+"-"+height+"-"+cvet
# 					price = nil
# 					cprice = nil
				
					data = { 
							sku: sku,
							title: title,
							sdesc: sdesc,
							desc: desc,
# 							cprice: cprice,
# 							price: price,
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
		
		puts "finish download Best - ""#{Time.now}"
	end
end