class AddImageDataToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :image_data, :text
  end
end
