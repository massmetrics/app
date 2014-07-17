require 'nokogiri'
require 'open-uri'
class AmazonScraper
  def initialize(url)
    @page = Nokogiri::HTML(open(url))
  end

  def price
    @page.xpath('//span[@id = "priceblock_ourprice"]').first.children.to_s
  end
end