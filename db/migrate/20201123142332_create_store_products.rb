class CreateStoreProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :store_products do |t|
      t.float :price
      t.references :product, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.timestamps
    end
  end
end
