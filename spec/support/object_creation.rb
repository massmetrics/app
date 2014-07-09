module ObjectCreation
  def self.create_product(attributes = {})
    default = {
      features: ["gets you jacked"],
      sku: "12345",
      detail_page_url: "google.com",
      review_url: "google.com/review",
      title: "google product",
      current_price: "5123",
      large_image_url: "google.com/large_image.jpeg",
      medium_image_url: "google.com/medium_image.jpeg",
      small_image_url: "google.com/small_image.jpeg",
      brand: "google"
    }
    default.merge!(attributes)
    Product.create(
      default
    )
  end

  def self.create_price_log(attributes = {})
    default = {
      product: Product.last
    }
    default.merge!(attributes)
    PriceLog.create(
      default
    )
  end
end