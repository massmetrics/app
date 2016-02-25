class Product < ActiveRecord::Base
  serialize :features
  validates_uniqueness_of :sku
  has_many :price_logs
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :my_products


  class << self
    def create_from_sku(sku)
      lookup = ItemLookup.new(sku)
      return unless lookup.items
      item = lookup.items.first
      current_price = item[:current_price] || AmazonScraper.new(item[:detail_page_url]).price
      create(
        features: item[:features],
        sku: item[:sku],
        detail_page_url: item[:detail_page_url],
        review_url: item[:review_url],
        title: item[:title].truncate(254),
        current_price: NumberFormatter.format_price_string(current_price),
        large_image_url: item[:large_image_url],
        medium_image_url: item[:medium_image_url],
        small_image_url: item[:small_image_url],
        brand: item[:brand]
      )
    end

    def create_multiple(sku_array)
      lookup = ItemLookup.new(sku_array)
      if lookup.items
        lookup.items.map do |item|
          begin
            create(item)
          rescue => e

          end
        end
      end
    end


    def percent_discounts(products)
      products.sort_by { |product| product.percent_off }.compact.reverse
    end

    def top_products_with_logs(products)
      percent_discounts(products).map do |product|
        [product, product.price_log_hash, product.percent_discount]
      end
    end

    def get_products_for(category)
      return Product.all unless category
      joins(:categories).where('categories.name = ?', category)
    end

    def category_discounts(category = nil, days = 30, items = 100)
      products = get_products_for(category).includes(:price_logs).references(:price_logs).where("price_logs.created_at >= ? ", days.days.ago).limit(items)
      top_products_with_logs(products)
    end

    def update_urls
      all.each do |product|
        product.update(
          detail_page_url: PostRank::URI.clean(product.detail_page_url),
          review_url: PostRank::URI.clean(product.review_url)
        )
      end
    end
  end

  def percent_off
    NumberConverter.percent_off(self.current_average_price.to_i, self.current_price)
  end

  def percent_discount(days = 30)
    if get_price_logs(days).length > 0
      NumberConverter.percent_off(current_average_price.to_i, current_price)
    else
      0
    end
  end

  def average_price(days = 30)
    price_logs = get_price_logs(days)
    return 0 if price_logs.length == 0
    sum = price_logs.reduce(0) { |memo, price| memo + price.price.to_i }
    sum / price_logs.length
  end

  def update_from_sku
    self.update(ItemLookup.new(self.sku).items.first)
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
      category = category.split(' ').map(&:capitalize).join(' ')

      unless Category.find_by(name: category)
        Category.create(name: category)
      end

      category_in_db = Category.find_by(name: category)

      unless categories.include?(category_in_db)
        ProductCategory.create(product_id: self.id, category_id: category_in_db.id)
      end
    end
  end

  def update_categories(category_array)
    self.product_categories.destroy_all
    self.add_categories(category_array)
  end
end
