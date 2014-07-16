# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# skus = ["B004EHXKU2", "B000QSNYGI", "B000QSNYGI", "B002HHREU8", "B003V5LXEI"]
# skus.each do |sku|
#   Product.create_from_sku(sku)
# end


def make_price_logs(item)
  [
    [product: item, created_at: 1.day.ago, price: rand(100000).to_s],
    [product: item, created_at: 2.day.ago, price: rand(100000).to_s],
    [product: item, created_at: 3.day.ago, price: rand(100000).to_s],
    [product: item, created_at: 4.day.ago, price: rand(100000).to_s],
    [product: item, created_at: 5.day.ago, price: rand(100000).to_s],
    [product: item, created_at: 6.day.ago, price: rand(100000).to_s],
    [product: item, created_at: 7.day.ago, price: rand(100000).to_s],
    [product: item, created_at: 8.day.ago, price: rand(100000).to_s],
    [product: item, created_at: 9.day.ago, price: rand(100000).to_s]
  ]
end

# Product.all.each do |item|
#   make_price_logs(item).each do |log|
#     PriceLog.create(log)
#   end
# end

Product.all.each do |item|
  item.add_categories(["protein", "protein powder"])
end