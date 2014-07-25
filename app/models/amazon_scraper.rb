require 'nokogiri'
require 'open-uri'
class AmazonScraper
  def initialize(url)
    @page = Nokogiri::HTML(open(url))
  end

  def price
    if @page.css('#priceblock_ourprice').length > 0
      @page.css('#priceblock_ourprice').text
    elsif @page.css('#priceblock_saleprice').length > 0
      @page.css('#priceblock_saleprice').text
    end
  end
end