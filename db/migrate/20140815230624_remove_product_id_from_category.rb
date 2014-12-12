class RemoveProductIdFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :product_id, :integer
  end
end
