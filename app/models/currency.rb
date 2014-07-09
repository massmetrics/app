class Currency

  def self.format_money(price)
    money = Money.new(price,'USD')
    money.format
  end
end