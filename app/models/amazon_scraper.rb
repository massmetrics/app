require 'nokogiri'
require 'open-uri'
class AmazonScraper
  def initialize(url)
    @page = Nokogiri::HTML(open(url))
    sleep 3
  end

  def price
    if @page.xpath('//span[@id = "priceblock_ourprice"]').first
      @page.xpath('//span[@id = "priceblock_ourprice"]').first.children.to_s
    elsif @page.xpath('//span[@id = "priceblock_saleprice"]').first
      @page.xpath('//span[@id = "priceblock_saleprice"]').first.children.to_s
    end
  end
end