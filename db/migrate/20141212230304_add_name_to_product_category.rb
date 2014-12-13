class AddNameToProductCategory < ActiveRecord::Migration
  def change
    add_column :product_categories, :name, :string
  end
end
