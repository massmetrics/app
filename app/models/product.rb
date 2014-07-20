class Product < ActiveRecord::Base
  serialize :features
  validates_uniqueness_of :sku
  has_many :price_logs
  has_many :categories

  class << self
    def create_from_sku(sku)
      item = ItemLookup.new(sku)
      current_price = AmazonScraper.new(item.detail_page_url).price || item.current_price
      create(
        features: item.features,
        sku: sku,
        detail_page_url: item.detail_page_url,
        review_url: item.review_url,
        title: item.title,
        current_price: NumberFormatter.format_price_string(current_price),
        large_image_url: item.large_image_url,
        medium_image_url: item.medium_image_url,
        small_image_url: item.small_image_url,
        brand: item.brand
      )
    end

    def averages(days = 30)
      averages = []
      all.each do |product|
        averages << [product, product.average_price(days)]
      end
      averages
    end

    def percent_discounts(items = 10, days = 30)
      percentages = []
      averages(days).each do |product|
        percentages << [product[0], (product[1].to_f - product[0].current_price.to_f)/product[1]]
      end
      percentages.sort_by { |product| product[1] }.reverse[0..items].map { |product| product[0] }
    end

    def get_products_for(category)
      Category.where(category: category).includes(:product).map { |cat| cat.product }
    end
  end

  def percent_discount(days = 30)
    if get_price_logs.length > 0
      ((average_price(days)).to_f - current_price.to_i) / average_price(days)
    else
      0
    end
  end

  def average_price(days = 30)
    sum = 0
    all_prices = get_price_logs(days)
    length = all_prices.length
    all_prices.each do |price|
      sum += price.price.to_i
    end
    if length == 0
      sum
    else
      sum / length
    end
  end

  def update_from_sku
    item = ItemLookup.new(self.sku)
    current_price = AmazonScraper.new(item.detail_page_url).price || item.current_price
    self.update(
      features: item.features,
      detail_page_url: item.detail_page_url,
      review_url: item.review_url,
      title: item.title,
      current_price: NumberFormatter.format_price_string(current_price),
      large_image_url: item.large_image_url,
      medium_image_url: item.medium_image_url,
      small_image_url: item.small_image_url,
      brand: item.brand
    )
  end

  def get_price_logs(days = 30)
    price_logs.where("created_at >= ?", days.days.ago)
  end

  def price_log_hash(days = 30)
    logs_hash = {}
    logs = get_price_logs(days)
    logs.each do |log|
      logs_hash[log.created_at.to_s] = (log.price.to_i/100).to_s + "." + (log.price.to_i%100).to_s
    end
    logs_hash
  end

  def add_categories(category_array)
    category_array.each do |category|
      Category.create(product: self, category: category)
    end
  end

  def self.category_discounts(category, days = 30, items = 10)
    output = []
    products = Product.get_products_for(category)
    products.each do |product|
      if product && product.get_price_logs(days).length > 0
        output << [product, (product.average_price(days).to_f - product.current_price.to_i)/ product.current_price.to_i]
      end
    end
    output.sort_by { |product| product[1] }.reverse[0..items].map { |product| product[0] }
  end
end