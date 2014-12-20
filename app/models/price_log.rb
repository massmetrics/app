class PriceLog < ActiveRecord::Base
  belongs_to :product
  after_create :update_current_average_price

  def date_string
    "#{created_at.strftime("%b")} #{created_at.day}"
  end

  def in_dollars
    '%.2f' % (price.to_i/100.0)
  end

  private
  def update_current_average_price
    product.update(current_average_price: product.average_price)
  end
end