def fetch_product (item)
  puts "Updating item with ID: #{item.id} #{Time.now.utc}"
  begin
    price = NumberFormatter.format_price_string(AmazonScraper.new(item.detail_page_url).price)
    if price.nil?
      puts "Price is nil for #{item.id}"
    else
      item.update(current_price: price, fetched: true)
    end

    item.reload
    PriceLog.create(price: item.current_price, product: item)
  rescue => e
    puts "Failed to fetch item: #{item.id}"
    item.update(fetched: false)
  end
end

namespace :product do
  desc('add new product to system')
  task :add_product, [:skus, :categories] => :environment do |t, args|
    category_array = args[:categories].split(' ')
    sku_array = args[:skus].split(' ')
    ProductAdder.add(sku_array, category_array)
  end

  desc('fetch updated product information')
  task :update_products => :environment do
    Product.all.each do |product|
      product.update(fetched: false)
      fetch_product(product)
    end
  end

  desc('refetch unfetched items')
  task :refetch_products => :environment do
    Product.where(fetched: false).each do |product|
      fetch_product(product)
    end
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
