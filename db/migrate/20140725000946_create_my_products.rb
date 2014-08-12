class CreateMyProducts < ActiveRecord::Migration
  def change
    create_table :my_products do |t|
      t.references :product, about: true
      t.references :user, about: true
    end
  end
end
