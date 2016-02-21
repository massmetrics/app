require 'rails_helper'

describe ProductAdder do
  it 'Adds a product and a category at the same time' do
    VCR.use_cassette('features/admin/submission/add_submission') do |cassette|
      new_time = cassette.originally_recorded_at || Time.now
      Timecop.freeze(new_time) do
        ProductAdder.add(['B00ARJN2TK'], ['Protein'])

        expect(Product.last.current_price.class).to eq(String)
        expect(Product.last.categories.first.name).to eq('Protein')
      end
    end
  end
end
