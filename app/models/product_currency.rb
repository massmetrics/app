class ProductCurrency
  def self.format_money(price)
    money = Money.new(price,'USD')
    money.format
  end
end