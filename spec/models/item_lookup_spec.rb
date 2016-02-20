require 'rails_helper'


describe ItemLookup do
  it 'can grab information for an item' do
    VCR.use_cassette('models/item_lookup/methods') do |cassette|
      new_time = cassette.originally_recorded_at || Time.now
      Timecop.freeze(new_time) do
        item = ItemLookup.new('B0047Y6I24')

        expect(item.detail_page_url).to eq('http://www.amazon.com/Myotein-Chocolate-Hydrolysate-Concentrate-Micellar/dp/B0047Y6I24?psc=1&SubscriptionId=AKIAJ7SLZLSJ62QB353Q&tag=massm0e-20&linkCode=xm2&camp=2025&creative=165953&creativeASIN=B0047Y6I24')
        expect(item.review_url).to eq('http://www.amazon.com/review/product/B0047Y6I24?SubscriptionId=AKIAJ7SLZLSJ62QB353Q&tag=massm0e-20&linkCode=xm2&camp=2025&creative=386001&creativeASIN=B0047Y6I24')
        expect(item.title).to eq('Myotein (Chocolate) - Best Whey Protein Powder / Shake - Great Tasting Protein Powder for Weight Loss & Muscle Growth - Hydrolysate, Isolate, Concentrate & Micellar Casein')
        expect(item.features).to eq(["This Premium Protein Blend Features 6 Types of Proteins", "Contains L-Glutamine, Aminogen, 20-Hydroxyecdysterone, Coleus Forskohlii, & Mucuna Pruriens to Support Recovery and Maximize Muscle Growth", "Time-Released Proteins For Sustained Protein Delivery", "26 Grams of Protein Per Serving", "Chef-Approved Best Tasting Milk Chocolate Flavor"])
        expect(item.current_price.class).to eq(REXMLUtiliyNodeString)
        expect(item.large_image_url).to eq('http://ecx.images-amazon.com/images/I/51u70wtsjOL.jpg')
        expect(item.small_image_url).to eq('http://ecx.images-amazon.com/images/I/51u70wtsjOL._SL75_.jpg')
        expect(item.medium_image_url).to eq('http://ecx.images-amazon.com/images/I/51u70wtsjOL._SL160_.jpg')
        expect(item.brand).to eq('XPI Supplements')
      end
    end
  end

  it 'uses current price if no price is returned' do
    VCR.use_cassette('models/item_lookup/to_hash') do |cassette|
      new_time = cassette.originally_recorded_at || Time.now
      Timecop.freeze(new_time) do
        item = ItemLookup.new('B00CTUIS12')

        expect(item.large_image_url).to eq(item.item["image_sets"]["image_set"].first["large_image"]["url"])
      end
    end
  end

  it 'turns features into an array if its not an array' do
    VCR.use_cassette('models/item_lookup/features') do |cassette|
      new_time = cassette.originally_recorded_at || Time.now
      Timecop.freeze(new_time) do
        item = ItemLookup.new('B000GIPJ0M')

        expect(item.features.class).to eq(Array)
      end
    end
  end
end