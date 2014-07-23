require 'rails_helper'

describe Submission do
  it 'requires both an sku and a category' do
    protein = Submission.new(sku: '12345')
    expect(protein.valid?).to eq(false)
    expect(protein.errors.full_messages).to eq(["Category can't be blank"])
    protein.sku = nil
    protein.category = "test"
    expect(protein.valid?).to eq(false)
    expect(protein.errors.full_messages).to eq(["Sku can't be blank"])
    protein.sku = "12345"
    expect(protein.valid?).to eq(true)
  end
end