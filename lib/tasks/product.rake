namespace :product do
  desc('add new product to system')
  task :add_product, [:sku] => :environment do |t, args|
    Product.create_from_sku(args[:sku])
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