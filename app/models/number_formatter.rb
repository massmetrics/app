class NumberFormatter
  class << self
    def format_percentage(percentage)
      percentage = (percentage * 10000).round / 100.0
      [percentage.to_s + "%", percentage]
    end

    def format_price_string(price_string)
      unless price_string.nil?
        price_string.tr('$.', '').split('-').first.strip
      end
    end

    def string_to_float(discount_string)
      if discount_string =~ /(?<=^| )\d+(\.\d+)?(?=$| )|(?<=^| )\.\d+(?=$| )/
        discount_string
      else
        0
      end
    end
  end
end