require 'spec_helper'

describe EmailJob do

  describe '#perform' do
    let(:user) { ObjectCreation.create_user}
    let(:product) { ObjectCreation.create_product}

    it 'delivers an email' do
      expect {
        EmailJob.new.perform(user, product)
      }.to change{ ActionMailer::Base.deliveries.size }.by(1)
    end
  end
end