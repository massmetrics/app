require 'rails_helper'

describe Submission do
  it 'requires both an sku and a category' do
    protein = Submission.new(sku: 'B0031JK96C')
    protein2 = Submission.new(category: 'test')
    expect(protein.valid?).to eq(false)
    expect(protein.errors.full_messages).to eq(["Category can't be blank"])
    expect(protein2.valid?).to eq(false)
    expect(protein2.errors.full_messages).to eq(["Sku can't be blank", "Sku is the wrong length (should be 10 characters)"])
  end

  context 'validations' do
    it 'validates length of sku' do
      valid_submission = Submission.new(sku: 'B0031JK96C', category: 'Protein')
      invalid_submission = Submission.new(sku: 'B', category: 'Protein')

      expect(valid_submission.valid?).to eq(true)
      expect(invalid_submission.valid?).to eq(false)
    end
  end
end