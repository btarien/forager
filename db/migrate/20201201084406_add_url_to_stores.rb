class AddUrlToStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :url, :string
  end
end
