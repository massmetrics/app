class CreateProductCategory < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.integer :product_id
      t.index :product_id
      t.integer :category_id
      t.index :category_id
    end
  end
end
