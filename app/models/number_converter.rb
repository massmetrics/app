class NumberConverter
  class << self
    def percent_off(average_price, current_price)
      (average_price.to_f - current_price.to_f)/average_price
    end
  end
end