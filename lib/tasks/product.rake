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

  desc('send users emails')
  task :send_emails => :environment do
    User.all.each do |user|
      user_notifications = user.notifications
      if user_notifications.length > 0
        products = []
        notifications =[]
        user_notifications.each do |notification|
          if notification[1].send_notification?
            products << notification[0]
            notifications << notification[1]
          end
        end
        puts "Sending notification to user: #{user.id}"
        EmailJob.new.async.perform(user, products)
        MyProductsNotification.update_notifications(notifications)
      end
    end
  end
end