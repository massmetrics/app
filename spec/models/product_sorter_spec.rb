require 'rails_helper'

describe ProductSorter do
  it 'returns an array of sorted products by their percent off' do
    p1 = ObjectCreation.create_product
    p2 = ObjectCreation.create_product(sku: '3213')
    p3 = ObjectCreation.create_product(sku: '51212')
    array = [[p1, 52.12], [p2, 32.12], [p3, 74.22]]
    expect(ProductSorter.sort_by_percentage(array)).to eq([p3, p1, p2])
  end
end