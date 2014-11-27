require 'nokogiri'
require 'open-uri'
class AmazonScraper
  def initialize(url)
    begin
      @page = Nokogiri::HTML(open(url, 'User-Agent' => 'ruby'))
    rescue OpenURI::HTTPError => error
      puts "Error is #{error.io.status}"
      retry
    end
  end

  def price
    if @page.css('#priceblock_ourprice').length > 0
      @page.css('#priceblock_ourprice').text
    elsif @page.css('#priceblock_saleprice').length > 0
      @page.css('#priceblock_saleprice').text
    end
  end
end