class CreateGroceries < ActiveRecord::Migration[6.0]
  def change
    create_table :groceries do |t|
      t.integer :quantity
      t.references :user, null: false, foreign_key: true
      t.references :store_product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
