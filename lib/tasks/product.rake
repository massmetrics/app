namespace :product do
  desc('add new product to system')
  task :add_product, [:sku, :categories] => :environment do |t, args|
    categories = args[:categories].split(' ')
    ProductAdder.add(args[:sku], categories)
  end

  desc('add new product to system')
  task :update_products => :environment do
    Product.all.each do |item|
      item.update_from_sku
      item.reload
      PriceLog.create(price: item.current_price, product: item)
    end
  end
end