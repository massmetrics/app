class PriceLog < ActiveRecord::Base
  belongs_to :product
  # after_create :check_discount

  def date_string
    created_at.to_s
  end

  def in_dollars
    '%.2f' % (price.to_i/100.0)
  end

  private
  def check_discount
    notifcations = self.product.my_products.map {|my_product| my_product.my_products_notification}
    discount = self.product.percent_discount
    notifcations.each do |notification|
      if discount >= notification.discount/100
        EmailJob.new.async.perform(notification.user, self.product)
      end
    end
  end
end

