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
      product: Product.last,
      price: "100"
    }
    default.merge!(attributes)
    PriceLog.create(
      default
    )
  end

  def self.create_category(attributes = {})
    default = {category: "Protein", product: Product.last}
    default.merge!(attributes)
    Category.create(
      default
    )
  end

  def self.create_product_with_category(category, product = {})
    new_product = self.create_product(product)
    self.create_category(category.merge!(product: new_product))
  end

  def self.create_user(attributes = {})
    default = {email: "#{rand(10000)}@example.com", password: 'password', password_confirmation: 'password'}
    default.merge!(attributes)
    User.create!(
      default
    )
  end

  def self.create_admin(attributes = {})
    default = {email: "#{rand(10000)}@example.com", password: 'password', password_confirmation: 'password', role: :admin}
    default.merge!(attributes)
    User.create!(
      default
    )
  end

  def self.create_notification(attributes={})
    user = create_user
    product = create_product(current_price: '80')
    create_price_log(product: product, price: '100')
    my_product = MyProduct.create(user: user, product: product)
    default = {my_product: my_product, discount: 10.0}
    default.merge!(attributes)
    MyProductsNotification.create(default)
  end
end

