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
      puts "Updated item with SKU: #{item.sku}"
      item.update_from_sku
      item.reload
      PriceLog.create(price: item.current_price, product: item)
      sleep 1
    end
  end
end