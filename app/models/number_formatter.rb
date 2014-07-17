class NumberFormatter
  class << self
    def format_percentage(percentage)
      percentage = (percentage * 10000).round / 100.0
      [percentage.to_s + "%", percentage]
    end

    def format_price_string(price_string)
      price_string.tr('$.', '')
    end
  end
end