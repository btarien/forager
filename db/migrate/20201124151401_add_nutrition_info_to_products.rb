class AddNutritionInfoToProducts < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'hstore'
    add_column :products, :nutrition, :hstore
    add_column :products, :ingredients, :string
  end
end
