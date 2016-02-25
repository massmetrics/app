require 'nokogiri'
require 'open-uri'
class AmazonScraper
  def initialize(url)
    tries = 0
    begin
      @page = Nokogiri::HTML(open(url, 'User-Agent' => 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6'))
    rescue OpenURI::HTTPError => error
      puts "Error is #{error.io.status.join(', ')}"
      puts "Retrying #{url}"
      tries += 1
      if tries <= 20
        retry
      end
    end
  end

  def price
    return nil unless @page.present?
    if @page.css('#priceblock_ourprice').length > 0
      @page.css('#priceblock_ourprice').text
    elsif @page.css('#priceblock_saleprice').length > 0
      @page.css('#priceblock_saleprice').text
    end
  end
end
