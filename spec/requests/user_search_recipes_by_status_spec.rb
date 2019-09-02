require 'rails_helper'

  describe 'User search recipes' do
    it 'by no params successfully' do
      user = User.create(email: 'email@email.com', password: '123456', admin: true)
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create!(user: user, title: 'Bolo de Cenoura', difficulty: 'Médio',
                              recipe_type: recipe_type, cuisine: 'Brasileira',
                              cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 1,
                              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
      other_recipe = Recipe.create!(user: user, title: 'Bolo de Chocolate', difficulty: 'Médio',
                              recipe_type: recipe_type, cuisine: 'Brasileira',
                              cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 0,
                              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      get '/api/v1/recipes/'

      expect(response.status).to eq 302
      expect(response.body).to include('Bolo de Cenoura')
      expect(response.body).to include('Bolo de Chocolate')
    end

    it 'and only accepted successfully' do
      user = User.create(email: 'email@email.com', password: '123456', admin: true)
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create!(user: user, title: 'Bolo de Cenoura', difficulty: 'Médio',
                              recipe_type: recipe_type, cuisine: 'Brasileira',
                              cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 1,
                              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
      other_recipe = Recipe.create!(user: user, title: 'Bolo de Chocolate', difficulty: 'Médio',
                                    recipe_type: recipe_type, cuisine: 'Brasileira',
                                    cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 0,
                                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
      another_recipe = Recipe.create!(user: user, title: 'Bolo de Chocolate Branco', difficulty: 'Médio',
                                      recipe_type: recipe_type, cuisine: 'Brasileira',
                                      cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 9,
                                      cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')


      get '/api/v1/recipes?status=accepted'

      expect(response.status).to eq 302
      expect(response.body).to include('Bolo de Cenoura')
      expect(response.body).not_to include(other_recipe.title)
      expect(response.body).not_to include(another_recipe.title)
    end
end
