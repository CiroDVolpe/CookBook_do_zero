class RecipeListItem < ApplicationRecord
  belongs_to :recipe
  belongs_to :recipe_list
  validates :recipe_id, uniqueness: {message: 'Já existe'}
end
