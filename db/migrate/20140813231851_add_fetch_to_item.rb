class AddFetchToItem < ActiveRecord::Migration
  def change
    add_column :products, :fetched, :boolean
  end
end
