require 'rails_helper'

describe ItemLookup do
  it 'can grab information for an item' do
    new_time = "2014-07-11T21:53:58Z"
    Timecop.freeze(new_time) do
      VCR.use_cassette('models/item_lookup') do
        item = ItemLookup.new("B0047Y6I24")
        expect(item.detail_page_url).to eq("http://www.amazon.com/Myotein-Chocolate-Protein-Tasting-Offered/dp/B0047Y6I24%3FSubscriptionId%3DAKIAJKOQZSKA7MQNOSZA%26tag%3Dmassmetr-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D165953%26creativeASIN%3DB0047Y6I24")
        expect(item.review_url).to eq("http://www.amazon.com/review/product/B0047Y6I24%3FSubscriptionId%3DAKIAJKOQZSKA7MQNOSZA%26tag%3Dmassmetr-20%26linkCode%3Dxm2%26camp%3D2025%26creative%3D386001%26creativeASIN%3DB0047Y6I24")
        expect(item.title).to eq("Myotein (Chocolate) - Best Whey Protein Powder - Best Tasting Protein Powder for Weight Loss and Muscle Growth - Best Protein Shake That's Offered")
        expect(item.features).to eq(["Features 6 Type of Protein to Enhance Protein Absorption", "PACKED With Whey Protein Isolates and Chef-Approved Best Tasting Milk Chocolate Flavor", "Great for maintaining and increasing lean muscle mass", "Uses the most concentrated form of protein available: Whey Protein Isolate for as much as 98% pure protein by weight", "26 Grams of High-Quality Protein Per Serving"])
        expect(item.current_price).to eq("6995")
        expect(item.large_image_url).to eq("http://ecx.images-amazon.com/images/I/518ZH7gfMsL.jpg")
        expect(item.small_image_url).to eq("http://ecx.images-amazon.com/images/I/518ZH7gfMsL._SL75_.jpg")
        expect(item.medium_image_url).to eq("http://ecx.images-amazon.com/images/I/518ZH7gfMsL._SL160_.jpg")
        expect(item.brand).to eq("XPI Supplements")
      end
    end
  end
end