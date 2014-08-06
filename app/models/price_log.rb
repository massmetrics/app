class PriceLog < ActiveRecord::Base
  belongs_to :product

  def date_string
    "#{created_at.strftime("%b")} #{created_at.day}"
  end

  def in_dollars
    '%.2f' % (price.to_i/100.0)
  end
end