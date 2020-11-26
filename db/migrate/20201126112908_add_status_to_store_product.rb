class AddStatusToStoreProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :store_products, :in_grocery, :boolean, default: true
  end
end
