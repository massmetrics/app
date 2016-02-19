require 'rails_helper'

describe ProductAdder do
  it 'Adds a product and a category at the same time' do
    new_time = "2016-02-19T13:54:10.287455"
    Timecop.freeze(new_time) do
      VCR.use_cassette('/models/product_adder/B000QSNYGI', :match_requests_on => [:method, :uri]) do
        ProductAdder.add(['B000QSNYGI'], ['Protein'])
        expect(Product.last.current_price).to eq('5799')
        expect(Product.last.categories.first.name).to eq('Protein')
      end
    end
  end
end