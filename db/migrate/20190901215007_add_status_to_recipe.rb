class AddStatusToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :rails, :string
    add_column :recipes, :g, :string
    add_column :recipes, :migration, :string
    add_column :recipes, :add_status_to_recipe, :string
    add_column :recipes, :status, :integer
  end
end
