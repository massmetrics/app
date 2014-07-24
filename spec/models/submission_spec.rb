require 'rails_helper'

describe Submission do
  context 'validations' do
    it 'validates length of sku' do
      valid_submission = Submission.new(sku: 'B0031JK96C', category: 'Protein')
      invalid_submission = Submission.new(sku: 'B', category: 'Protein')

      expect(valid_submission.valid?).to eq(true)
      expect(invalid_submission.valid?).to eq(false)
    end

    it 'validates presence of sku' do
      valid_submission = Submission.new(sku: 'B0031JK96C', category: 'Protein')
      invalid_submission = Submission.new(category: 'Protein')

      expect(valid_submission.valid?).to eq(true)
      expect(invalid_submission.valid?).to eq(false)
      expect(invalid_submission.errors.full_messages).to eq(['Sku can\'t be blank', 'Sku Invalid SKU'])
    end

    it 'validates presence of category' do
      valid_submission = Submission.new(sku: 'B0031JK96C', category: 'Protein')
      invalid_submission = Submission.new(sku: 'B0031JK96C')

      expect(valid_submission.valid?).to eq(true)
      expect(invalid_submission.valid?).to eq(false)
      expect(invalid_submission.errors.full_messages).to eq(['Category can\'t be blank'])
    end
  end
end