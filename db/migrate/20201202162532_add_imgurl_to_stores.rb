class AddImgurlToStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :imgurl, :string
  end
end
