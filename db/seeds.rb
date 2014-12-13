# Product.all.each do |item|
#   item.add_categories(["protein", "protein powder"])
# end

categories = ['Protein Powder', 'Pre Workout', 'Post Workout', 'Protein Bar','Vitamin', 'Fat Burner' 'Creatine', 'CLA']

categories.each do |category|
  Category.create!(name: category)
end

powders = ["B00ARJN2TK", "B00BEOHFKO", "B000GOY7FO", "B000GOY6Z0", "B002DYJ0OI", "B00FFDSER8", "B002QZORGK", "B000GIPJ0M", "B00HQNNS6C", "B002DYJ0K2", "B002DUD6QU"]

pre_workouts = ["B00E7ZKE0U", "B00F46JJGG", "B00F108EQQ", "B002FK37M6", "B00FAYLDXY", "B00A7D1TSW", "B00E4VE3AE", "B00HT2H1LI", "B002NU6FC2", "B009AOI86K", "B00FE6FJ7O", "B005DEMQLE", "B00ENQ3ANQ", "B00I0BR3XS", "B00EOA2686", "B007JUOM8A", "B00F108EQQ"]

post_workouts = ["B006R76WK2", "B00HX02IGO", "B0056XU5XS", "B0055BYD66", "B000SOXALE", "B00HM9OJFY", "B00JQ3WXS4", "B0093NRL6Q", "B00IA9QS8G", "B00B2OK1K2"]

protein_bars = ["B00DLDH1N2", "B00CTUIS12", "B000FRVPUM", "B00FN1S0YE", "B0035J3XC0", "B000QH5JSU", "B001RD6L98", "B004JRQ3DS", "B00CSJMH8E", "B004JRQ3DS"]

multi_vitamins = ["B0015R3AAO", "B000GOT54C", "B000GIQRW6", "B0056XU6W8", "B00FDP658I", "B00104I5TS", "B00KY9OAJ4", "B003ENHSI2" ]

fat_burners = ["B007LAHS2K", "B007G8S6O6", "B003SP60XK", "B008B8BT4E", "B00FCGLJ4S", "B0097BZJXG", "B00HYMR3ZW", "B00HFF23RQ", "B000GOO00Q"]

creatine = ["B002RWJQMC", "B002DYIZEO", "B0056XU7K4", "B00F9CHC2I", "B0051ZH17E", "B00117ZRXQ", "B00ISS3968", "B008LQT880", "B0009V8MA0"]

cla = ['B008E77A0O', 'B000Z8Z93K', 'B00EVMVU0W', 'B00HFF23RQ', 'B002DYJ0CU', 'B00G6H03NA', 'B00D62KG26', 'B00005317T', 'B00166BCAY']

  ProductAdder.add(powders, ['Protein Powder'])

  ProductAdder.add(pre_workouts, ['Pre Workout'])

  ProductAdder.add(post_workouts, ['Post Workout'])

  ProductAdder.add(protein_bars, ['Protein Bar'])

  ProductAdder.add(multi_vitamins, ['Vitamin'])

  ProductAdder.add(fat_burners, ['Fat Burner'])

  ProductAdder.add(creatine, ['Creatine'])

  ProductAdder.add(cla, ['CLA'])

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

Product.all.each do |item|
  make_price_logs(item).each do |log|
    PriceLog.create(log)
  end
end