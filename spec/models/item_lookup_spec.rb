require 'rails_helper'

describe ItemLookup do
  it 'can grab information for an item' do
    new_time = '2014-07-24T04:12:31Z'
    Timecop.freeze(new_time) do
      VCR.use_cassette('models/item_lookup') do
        item = ItemLookup.new('B0047Y6I24')

        expect(item.detail_page_url).to eq('http://www.amazon.com/Myotein-Chocolate-Protein-Tasting-Offered/dp/B0047Y6I24%3FSubscriptionId%3DAKIAJKOQZSKA7MQNOSZA%26tag%3Dmassmetr-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB0047Y6I24')
        expect(item.review_url).to eq('http://www.amazon.com/review/product/B0047Y6I24%3FSubscriptionId%3DAKIAJKOQZSKA7MQNOSZA%26tag%3Dmassmetr-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB0047Y6I24')
        expect(item.title).to eq('Myotein (Chocolate) - Best Whey Protein Powder - Best Tasting Protein Powder for Weight Loss and Muscle Growth - Best Protein Shake That\'s Offered')
        expect(item.features).to eq(["This Premium Protein Blend Features 6 Types of Proteins to Enhance Protein Absorption", "Contains L-Glutamine, Aminogen, 20-Hydroxyecdysterone, Coleus Forskohlii, & Mucuna Pruriens to Support Recovery and Maximize Muscle Growth", "Sweetened With Honey", "26 Grams of Protein Per Serving", "Chef-Approved Best Tasting Milk Chocolate Flavor"])
        expect(item.current_price).to eq('4995')
        expect(item.large_image_url).to eq('http://ecx.images-amazon.com/images/I/51HK23s4gHL.jpg')
        expect(item.small_image_url).to eq('http://ecx.images-amazon.com/images/I/51HK23s4gHL._SL75_.jpg')
        expect(item.medium_image_url).to eq('http://ecx.images-amazon.com/images/I/51HK23s4gHL._SL160_.jpg')
        expect(item.brand).to eq('XPI Supplements')
      end
    end
  end

  it 'uses current price if no price is returned' do
    new_time = "2014-07-24T20:42:46Z"
    Timecop.freeze(new_time) do
      VCR.use_cassette('models/item_lookup/to_hash') do
        item = ItemLookup.new('B00CTUIS12')
        expect(item.large_image_url).to eq(item.item["image_sets"]["image_set"].first["large_image"]["url"])
      end
    end
  end
end