class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :product, index: true
      t.string :category
    end
  end
end
