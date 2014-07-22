class CreateSubmission < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :sku
      t.string :category
    end
  end
end
