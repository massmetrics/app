require 'rails_helper'

describe AmazonScraper do
  it 'Can grab the price of the product' do
    VCR.use_cassette('amazon_scraper/body_fortress') do
      product = ObjectCreation.create_product(detail_page_url: "http://www.amazon.com/Body-Fortress-Advanced-Protein-Strawberry/dp/B002HHPLGW/ref=sr_1_12?ie=UTF8&qid=1405631719&sr=8-12&keywords=protein+powder")

      body_fortress = AmazonScraper.new(product.detail_page_url)

      expect(body_fortress.price).to eq('$17.98')
    end
  end
end