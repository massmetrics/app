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
    default = {name: "Protein"}
    default.merge!(attributes)
    Category.find_or_create_by!(default)
  end


  def self.create_product_with_category(category, product = {})
    product = self.create_product(product)
    new_category = self.create_category(category)

    ProductCategory.create(product_id: product.id, category_id: new_category.id)
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

  def self.create_notification(attributes = {})
      user = ObjectCreation.create_user
      product = ObjectCreation.create_product(sku: "#{rand(10000)}", current_price: '80')
      ObjectCreation.create_price_log(product: product, price: '100')
      my_product = MyProduct.create(user: user, product: product)
      default = {my_product: my_product, discount: 10.0}
      default.merge!(attributes)
      MyProductsNotification.create(default)
  end

  def self.create_product_with_product_category(attributes = {product: {}, category: {}})
    product = create_product(attributes[:product])
    category = create_category(attributes[:category])

    ProductCategory.create(product: product, category: category)
  end
end