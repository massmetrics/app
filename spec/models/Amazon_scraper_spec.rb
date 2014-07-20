require 'rails_helper'

describe AmazonScraper do
  it 'Can grab the price of the product' do
    VCR.use_cassette('amazon_scraper/body_fortress') do
      product = ObjectCreation.create_product(detail_page_url: "http://www.amazon.com/Body-Fortress-Advanced-Protein-Strawberry/dp/B002HHPLGW/ref=sr_1_12?ie=UTF8&qid=1405631719&sr=8-12&keywords=protein+powder")

      body_fortress = AmazonScraper.new(product.detail_page_url)

      expect(body_fortress.price).to eq('$17.98')
    end
    VCR.use_cassette('amazon_scraper/labrada') do
      product = ObjectCreation.create_product(detail_page_url: "http://www.amazon.com/Labrada-Nutrition-Essential-Capsules-180-Count/dp/B00HQNNS6C/ref=sr_1_1?ie=UTF8&qid=1405887875&sr=8-1&keywords=LABRADA+EFA+LEAN+GOLD")
      labrada = AmazonScraper.new(product.detail_page_url)
      expect(labrada.price).to eq('$25.00')
    end
  end
end