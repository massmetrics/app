# TODO move these out of this file and test them
# TODO make another method to diff other attributes

def fetch_product (item)
  puts "Updating item with ID: #{item.id} #{Time.now.utc}"
  begin
    price = NumberFormatter.format_price_string(ItemLookup.new(item.sku).items.first[:current_price])
    if price.nil?
      puts "Price is nil for #{item.id}"
    else
      puts "Price for #{item.id} is #{price}"
      item.update(current_price: price, fetched: true)
    end

    item.reload
    PriceLog.create(price: item.current_price, product: item)
  rescue => e
    puts e
    puts "Failed to fetch item: #{item.id}"
    item.update(fetched: false)
  end
end

def fetch_products(skus)
  bad_skus = []
  lookup = ItemLookup.new(skus)
  items = lookup.items
  items.each do |item|
    product = Product.find_by_sku(item[:sku])
    price = NumberFormatter.format_price_string(item[:current_price])
    begin
      if price.nil?
        puts "Price is nil for Product: #{item[:sku]}"
        bad_skus << item[:sku]
      else
        puts "Price for #{item[:sku]} is #{price}"
        product.update(current_price: price, fetched: true)
      end
      product.reload
      PriceLog.create(price: product.current_price, product: product)
    rescue => e
      puts e
      puts "Failed to fetch item: #{product.sku}"
      product.update(fetched: false)
    end
  end

  bad_skus
end


namespace :product do
  desc('add new product to system')
  task :add_product, [:skus, :categories] => :environment do |_, args|
    category_array = args[:categories].split(' ')
    sku_array = args[:skus].split(' ')
    Product.create_multiple(sku_array)
    ProductAdder.add_category(sku_array, category_array)
  end

  desc('update categories to new product category')
  task :update_categories => :environment do
    Product.all.each do |product|
      product.categories.each do |category|
        ProductCategory.find_or_create_by(product: product, category: category, name: category.name)
      end
    end

    Category.delete_all

    ProductCategory.all.each do |pc|
      category = Category.where(name: pc.name).first_or_create(name: pc.name)

      pc.update(category: category)
    end
  end

  desc('fetch updated product information')
  task :update_products => :environment do
    bad_skus = []
    Product.update_all(fetched: false)
    Product.all.pluck(:sku).each_slice(10) { |slice| bad_skus << fetch_products(slice) }
    if bad_skus.length > 0
      puts "Check on the following SKUs for issues: "
      bad_skus.each do |sku|
        puts sku
      end
    end
  end

  desc('refetch unfetched items')
  task :refetch_products => :environment do
    product_skus = Product.where(fetched: false).pluck(:sku)
    product_skus.each_slice(10) { |slice| fetch_products(slice) }
  end

  desc('send users emails')
  task :send_emails => :environment do
    notifications = NotificationAggregator.aggregate
    notifications.each do |notification|
      EmailJob.new.async.perform(notification[0], notification[1])
    end
  end

  desc('remove old price logs')
  task :remove_price_logs => :environment do
    PriceLog.where("created_at <= ?", 30.days.ago).destroy_all
  end
end
