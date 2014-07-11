class NumberFormatter
  class << self
    def format_percentage(percentage)
      percentage = (percentage * 10000).round / 100.0
      [percentage.to_s + "%", percentage]
    end
  end
end