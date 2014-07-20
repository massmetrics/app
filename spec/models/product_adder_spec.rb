require 'rails_helper'

describe ProductAdder do
  it 'Adds a product and a category at the same time' do
    new_time = "2014-07-19T21:48:14Z"
    Timecop.freeze(new_time) do
      VCR.use_cassette('/models/product_adder/B000QSNYGI') do
        product = ProductAdder.add("B000QSNYGI", ["Protein"])
        expect(product.current_price).to eq("5799")
        expect(product.categories.first.category).to eq("Protein")
      end
    end
  end
end