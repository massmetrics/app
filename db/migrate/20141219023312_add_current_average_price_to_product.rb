class AddCurrentAveragePriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :current_average_price, :int
  end
end
