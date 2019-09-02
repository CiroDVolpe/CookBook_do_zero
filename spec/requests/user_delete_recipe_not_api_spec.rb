require 'rails_helper'

  describe 'User try to delete a recipe by route and is not his'do
    it 'and fails' do
      user = User.create(email: 'email@email.com', password: '123456', admin: false)
      other_user = User.create(email: 'apagador@email.com', password: '123456', admin: true)
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create!(user: user, title: 'Bolo de Cenoura', difficulty: 'Médio',
                              recipe_type: recipe_type, cuisine: 'Brasileira',
                              cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 0,
                              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      sign_in other_user
      delete "/recipes/#{recipe.id}"

      expect(response).to redirect_to(root_path)
    end
  end
