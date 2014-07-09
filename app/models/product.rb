class Product < ActiveRecord::Base
  serialize :features
  validates_uniqueness_of :sku
  has_many :price_logs

  def self.create_from_sku(sku)
    item = ItemLookup.new(sku)
    create(
      features: item.features,
      sku: sku,
      detail_page_url: item.detail_page_url,
      review_url: item.review_url,
      title: item.title,
      current_price: item.current_price,
      large_image_url: item.large_image_url,
      medium_image_url: item.medium_image_url,
      small_image_url: item.small_image_url,
      brand: item.brand
    )
  end

  def update_from_sku
    item = ItemLookup.new(self.sku)
    self.update(
      features: item.features,
      detail_page_url: item.detail_page_url,
      review_url: item.review_url,
      title: item.title,
      current_price: item.current_price,
      large_image_url: item.large_image_url,
      medium_image_url: item.medium_image_url,
      small_image_url: item.small_image_url,
      brand: item.brand
    )
  end

  def get_prices(days = 30)
    price_logs.where("created_at >= ?", days.days.ago)
  end

  def price_log_hash(days = 30)
    logs_hash = {}
    logs = get_prices(days)
    logs.each do |log|
      logs_hash[log.created_at.to_s] = (log.price.to_i/100).to_s + "." + (log.price.to_i%100).to_s
    end
    logs_hash
  end
end