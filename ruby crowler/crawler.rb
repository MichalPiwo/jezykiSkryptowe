# during running on windows 10  there can be some errors, gem install ffi can solve it
require "watir"
require "webdrivers"
require "nokogiri"


product = "klawiatura"
url_address = "https://allegro.pl/listing?string=#{product}"


browser = Watir::Browser.new
browser.goto url_address
parsed_page = Nokogiri::HTML(browser.html)


products = parsed_page.xpath("//div[contains(@class, 'mpof_ki mqen_m6 mp7g_oh mh36_0 mvrt_0 mg9e_8 mj7a_8 m7er_k4 _1y62o _6a66d_snEkI')]")

puts ""

if products.respond_to?("each")
	products.each.with_index do |prod, index|
		# puts prod
		puts "produkt nr #{index}"
		link = prod.xpath(".//a[contains(@class, '_w7z6o _uj8z7 meqh_en mpof_z0 mqu1_16 m6ax_n4 _6a66d_LX75-')]/@href")
		tytul = prod.xpath(".//a[contains(@class, '_w7z6o _uj8z7 meqh_en mpof_z0 mqu1_16 m6ax_n4 _6a66d_LX75-')]").children
		cena = prod.xpath(".//div[contains(@class, 'mpof_92 myre_zn')]//span[contains(@class, '_1svub _lf05o')]/@aria-label").text
		puts "tytuł: #{tytul}"
		puts "cena: #{cena.split(' ')[0...-2].join(' ')}"
		puts ""
		puts ""
	end
end

browser.close