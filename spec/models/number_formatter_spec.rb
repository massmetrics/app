require 'rails_helper'

describe NumberFormatter do
  it 'formats percentages for displaying purposes' do
    percentage = 0.3333333333333

    expect(NumberFormatter.format_percentage(percentage)).to eq(['33.33%', 33.33])
  end

  it 'strips $ and . from a string' do
    amount = '$17.95'

    expect(NumberFormatter.format_price_string(amount)).to eq('1795')
  end

  it 'chooses the first number if a range is given' do
    amount = '$24.30 - $59.15'

    expect(NumberFormatter.format_price_string(amount)).to eq('2430')
  end

  it 'returns 0 if passed any non-digit characters except .' do
    discount = '12jkawd3%'

    expect(NumberFormatter.string_to_float(discount)).to eq(0)
  end

  it 'returns the string passed in if there are no invalid characters' do
    discount = '12.52'

    expect(NumberFormatter.string_to_float(discount)).to eq('12.52')
  end
end