class CreateCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :product, about: true
      t.string :category
    end
  end
end
