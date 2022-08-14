namespace :alvitek do
  desc "Tasks for alvitek"
  
	task get: :environment do
	require 'mechanize'
	require 'open-uri'
	puts 'start'
		a = Mechanize.new
		a.get("http://alvitek.com.ru/")
		form = a.page.forms[1]
		form.USER_LOGIN = "finenko72@hotmail.com"
		form.USER_PASSWORD = "Финенко"
		form.submit
		a.get("http://alvitek.com.ru/personal/last/")
		a.cookie_jar.save("cookies.yaml", session: true)
		yaml_file=YAML.load_file('cookies.yaml')
		yaml_file.each do |k,v|
		@sessid = v["/"]["PHPSESSID"].to_s.split('=').last.to_s
		end
		puts @sessid
		url = 'http://alvitek.com.ru/local/components/al/export.catalog/ajax.php?sessid='+@sessid
		puts url
		ajax_headers = { 'X-Requested-With' => 'XMLHttpRequest', 'Content-Type' => 'application/json; charset=utf-8', 'Accept' => 'application/json', 'Accept-Language'=>'en-GB,en-US;q=0.9,en;q=0.8,ru'}
		resp = a.post(url, {"ACTION"=> "startExport", "DATA"=> {"PROFILE"=> "1223"}, "CLASS"=> "Alvitek\Partners\Export\ExportFile"},ajax_headers)
		puts resp.header
		b=JSON.parse(resp.body)
		puts b #.force_encoding("windows-1251").encode("utf-8")
		download_path = "#{Rails.public_path}"+"/1ba3ee640de498b901ff4cdcd6f8bd48.csv"
# 		File.open(download_path, "w+") do |f|
# 			f.write(download_response)
# 		end
		download = open('http://alvitek.com.ru/upload/export_xls/1ba3ee640de498b901ff4cdcd6f8bd48.csv')
		IO.copy_stream(download, download_path)
		
	puts 'finish'
	end

end
