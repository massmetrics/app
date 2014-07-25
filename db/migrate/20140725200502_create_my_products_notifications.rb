class CreateMyProductsNotifications < ActiveRecord::Migration
  def change
    create_table :my_products_notifications do |t|
      t.references :my_product, index: true
      t.float :discount
    end
  end
end
