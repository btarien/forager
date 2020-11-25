class AddNutritionInfoToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :nutrition, :json
    add_column :products, :ingredients, :string
  end
end
