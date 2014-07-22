require 'rails_helper'

describe ProductCurrency do
  it 'formats price from cents to dollars' do

      expect(ProductCurrency.format_money('100000')).to eq('$1,000.00')
    end
  end