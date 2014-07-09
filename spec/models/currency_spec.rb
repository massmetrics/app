require 'rails_helper'

describe Currency do
  it "formats price from cents to dollars" do

      expect(Currency.format_money("100000")).to eq("$1,000.00")
    end
  end