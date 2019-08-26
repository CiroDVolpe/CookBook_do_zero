require 'rails_helper'

describe RecipeList do
  describe 'recipe belongs to list' do
    it 'can have many recipes' do
      user  = User.create!(email: 'carinha@mail.com', password: '123456')
      recipe_type = RecipeType.create!(name:'Sobremesa')
      recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: 'Brasileira',
                           cook_time: 50,user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços'\
                           ' pequenos, misture com o restante dos ingredientes')
      other_recipe = Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: 'Brasileira',
                           cook_time: 50,user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços'\
                           ' pequenos, misture com o restante dos ingredientes')
      list = RecipeList.create!(name: 'Doces', user: user)
      RecipeListItem.create!(recipe: recipe, recipe_list: list)
      RecipeListItem.create!(recipe: other_recipe, recipe_list: list)
      expect(list.recipes).to include recipe
      expect(list.recipes).to include other_recipe
    end
  end
end