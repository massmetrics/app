class Product < ActiveRecord::Base
  serialize :features
  validates_uniqueness_of :sku
  has_many :price_logs
  has_many :categories
  has_many :my_products

  class << self
    def create_from_sku(sku)
      item = ItemLookup.new(sku)
      if item.item
        current_price = AmazonScraper.new(item.detail_page_url).price || item.current_price
        create(
          features: item.features,
          sku: sku,
          detail_page_url: item.detail_page_url,
          review_url: item.review_url,
          title: item.title.truncate(254),
          current_price: NumberFormatter.format_price_string(current_price),
          large_image_url: item.large_image_url,
          medium_image_url: item.medium_image_url,
          small_image_url: item.small_image_url,
          brand: item.brand
        )
      end
    end

    def percent_discounts(items = 10, days = 30)
      includes(:price_logs).sort_by { |product| product.percent_off(days) }.reverse[0...items].compact
    end

    def top_products_with_logs(items = 10, days = 30)
      percent_discounts(items, days).map do |product|
        [product, product.price_log_hash, product.percent_discount]
      end
    end

    def get_products_for(category)
      includes(:categories).where(categories: {category: category})
    end

    def category_discounts(category, days = 30, items = 10)
      products = get_products_for(category).includes(:price_logs)
      products = products.where("price_logs.created_at >= ? ", days.days.ago)
      products.top_products_with_logs(items, days)
    end

    def update_urls
      all.each do |product|
        item = ItemLookup.new(product.sku)
        product.update(detail_page_url: item.detail_page_url, review_url: item.review_url)
        wait 1
      end
    end
  end

  def percent_off(days)
    NumberConverter.percent_off(self.average_price(days), self.current_price)
  end

  def percent_discount(days = 30)
    if get_price_logs(days).length > 0
      NumberConverter.percent_off(average_price(days), current_price)
    else
      0
    end
  end

  def average_price(days = 30)
    price_logs = get_price_logs(days)
    sum = price_logs.reduce(0) { |memo, price| memo + price.price.to_i }
    price_logs.length > 0 ? sum / price_logs.length : 0
  end

  def update_from_sku
    self.update(ItemLookup.new(self.sku).to_hash)
  end

  def get_price_logs(days = 30)
    price_logs.sort_by { |log| log.created_at }.select do |log|
      log.created_at >= days.day.ago
    end
  end

  def price_log_hash(days = 30)
    get_price_logs(days).reduce({}) do |logs_hash, log|
      logs_hash[log.date_string] = log.in_dollars
      logs_hash
    end
  end

  def add_categories(category_array)
    category_array.each do |category|
      self.reload
      categories = self.categories.map { |c| c.category.downcase }
      unless categories.include?(category.downcase.strip)
        Category.create(product: self, category: category)
      end
    end
  end

  def
  update_categories(category_array)
    self.categories.destroy_all
    self.add_categories(category_array)
  end
end