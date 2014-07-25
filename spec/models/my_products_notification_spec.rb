require 'rails_helper'

describe MyProductsNotification do

  context 'validations' do
    it 'is invalid when a discount is 0 or greater than or equal to 100' do
      valid_discount = MyProductsNotification.new(discount: '50.0')
      invalid_discount = MyProductsNotification.new(discount: '101')
      invalid_discount2 = MyProductsNotification.new(discount: '0')

      expect(invalid_discount).to_not be_valid
      expect(invalid_discount2).to_not be_valid
      expect(valid_discount).to be_valid
    end
  end
end
