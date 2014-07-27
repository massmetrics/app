namespace :product do
  desc('add new product to system')
  task :add_product, [:skus, :categories] => :environment do |t, args|
    category_array = args[:categories].split(' ')
    sku_array = args[:skus].split(' ')
    ProductAdder.add(sku_array, category_array)
  end

  desc('add new product to system')
  task :update_products => :environment do
    Product.all.each do |item|
      puts "Updating item with ID: #{item.id}"
      price = NumberFormatter.format_price_string(AmazonScraper.new(item.detail_page_url).price)
      if price.nil?
        puts "Price is nil for #{item.id}"
      else
        item.update(current_price: price)
      end
      item.reload
      PriceLog.create(price: item.current_price, product: item)
    end
  end
end