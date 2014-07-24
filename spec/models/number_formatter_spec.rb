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
end