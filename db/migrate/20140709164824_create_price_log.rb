class CreatePriceLog < ActiveRecord::Migration
  def change
    create_table :price_logs do |t|
      t.string :price
      t.references :product, about: true
      t.timestamps
    end
  end
end