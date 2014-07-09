class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :sku
      t.string :detail_page_url
      t.string :review_url
      t.string :title
      t.text :features
      t.string :current_price
      t.string :large_image_url
      t.string :small_image_url
      t.string :medium_image_url
      t.string :brand
    end
  end
end
