require 'rails_helper'

describe NumberConverter do
  it 'can calculate the percent off' do
    expect(NumberConverter.percent_off(25, 20)).to eq(0.2)
  end
end