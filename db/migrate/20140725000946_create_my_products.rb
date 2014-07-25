class CreateMyProducts < ActiveRecord::Migration
  def change
    create_table :my_products do |t|
      t.references :product, index: true
      t.references :user, index: true
    end
  end
end
