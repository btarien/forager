class AddNameClassToStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :name_class, :string
  end
end
