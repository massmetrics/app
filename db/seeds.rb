categories = ['Protein Powder', 'Pre Workout', 'Post Workout', 'Protein Bar', 'Vitamin', 'Fat Burner' 'Creatine', 'CLA', 'Nootropics']

categories.each do |category|
  Category.find_or_create_by!(name: category)
end
# Product.create_multiple(['B00ARJN2TK', 'B00BEOHFKO', 'B000GOY7FO'])
#commented out old asins.
#"B00A7D1TSW",B00F46JJGG, "B00F108EQQ""B007JUOM8A","B00I0BR3XS", "B00KY9OAJ4 "B00ENQ3ANQ","B00E4VE3AE","B002NU6FC2","B005DEMQLE",B001RD6L98,"B00CSJMH8E","B0097BZJXG", B000Z8Z93K, "B00FE6FJ7O", "B00JQ3WXS4","B000GOO00Q","B0051ZH17E""B00E7ZKE0U"B00104I5TS, "B00HM9OJFY",

powders = %w( B00ARJN2TK B00BEOHFKO B000GOY7FO B000GOY6Z0 B002DYJ0OI B002QZORGK B000GIPJ0M B00HQNNS6C B002DYJ0K2 B002DUD6QU B00BEOHFKO B000GOY7FO B000GOY6Z0 B002DYJ0OI B00FFDSER8 B002QZORGK B00ARJN2TK B002DYJ0K2 B00FAYLDXY B002DUD6QU B00HQNNS6C )

pre_workouts = %w(B00E7ZKE0U B006R76WK2 B00EOA2686 B002FK37M6 B00FAYLDXY B00HT2H1LI B00FE6FJ7O B009AOI86K B00FE6FJ7O B00EOA2686 )

post_workouts = %w(B006R76WK2 B006R76WK2 B00HX02IGO B0056XU5XS B0055BYD66 B000SOXALE B0093NRL6Q B00IA9QS8G B00B2OK1K2 )

protein_bars = %w(B00DLDH1N2 B00CTUIS12 B000FRVPUM B00FN1S0YE B0035J3XC0 B000QH5JSU B004JRQ3DS B004JRQ3DS )

multi_vitamins = %w(B0015R3AAO B000GOT54C B000GIQRW6 B0056XU6W8 B00FDP658I B003ENHSI2 )

fat_burners = %w(B007LAHS2K B007G8S6O6 B003SP60XK B008B8BT4E B00FCGLJ4S B00HYMR3ZW B00HFF23RQ )

creatine = %w( B002RWJQMC B002DYIZEO B0056XU7K4 B00F9CHC2I B00117ZRXQ B00ISS3968 B008LQT880 B0009V8MA0 )

cla = %w( B008E77A0O B00EVMVU0W B00HFF23RQ B002DYJ0CU B00G6H03NA B00D62KG26 B00005317T B00166BCAY )

bcaa= %w( B00B2OK1K2 B00IA9QS8G B00HX02IGO B000SOXALE B006R76WK2 B0093NRL6Q B0056XU5XS B0055BYD66)

# ["B0035J3XC0", "B000QH5JSU", "B004JRQ3DS", "B0015R3AAO", "B000GOT54C", "B000GIQRW6", "B0056XU6W8", "B00FDP658I", "B00KY9OAJ4", "B003ENHSI2"]
all_skus = [powders, pre_workouts, post_workouts, protein_bars, multi_vitamins, fat_burners, creatine, cla, bcaa].flatten!.uniq!

all_skus.each_slice(10) do |sku_array|
  Product.create_multiple(sku_array)
end

ProductAdder.add_category(powders, ['Protein Powder'])

ProductAdder.add_category(pre_workouts, ['Pre Workout'])

ProductAdder.add_category(post_workouts, ['Post Workout'])

ProductAdder.add_category(protein_bars, ['Protein Bar'])

ProductAdder.add_category(multi_vitamins, ['Vitamin'])

ProductAdder.add_category(fat_burners, ['Fat Burner'])

ProductAdder.add_category(creatine, ['Creatine'])

ProductAdder.add_category(cla, ['CLA'])

ProductAdder.add_category(bcaa, ['Bcaa'])

Product.all.each do |product|
  PriceLog.create(price: product.current_price, product: product)
end