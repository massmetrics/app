require 'spec_helper'

describe EmailJob do

  describe '#perform' do
    let(:user) { ObjectCreation.create_user}
    let(:product1) { ObjectCreation.create_product}
    let(:product2) { ObjectCreation.create_product(sku: '3213')}

    it 'delivers an email' do
      expect {
        EmailJob.new.perform(user, [product1, product2])
      }.to change{ ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end