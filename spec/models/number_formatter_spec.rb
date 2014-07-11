require 'rails_helper'

describe NumberFormatter do
  it 'formats percentages for displaying purposes' do
    percentage = 0.3333333333333

    expect(NumberFormatter.format_percentage(percentage)).to eq(["33.33%", 33.33])
  end
end