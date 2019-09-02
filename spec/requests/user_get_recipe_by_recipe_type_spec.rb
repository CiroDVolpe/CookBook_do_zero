require 'rails_helper'

describe 'User get recipe by recipe type' do
    it 'successfully' do
      user = User.create!(email: 'email@email.com', password: '123456')
	    recipe_type = RecipeType.create(name: 'Sobremesa')
	    another_recipe_type = RecipeType.create(name: 'Massas')
	    Recipe.create(user: user, title: 'Pudim', difficulty: 'Médio',
	                  recipe_type: recipe_type, cuisine: 'Brasileira',
	                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
	                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
	    Recipe.create(user: user, title: 'Quindim', difficulty: 'Médio',
	                  recipe_type: recipe_type, cuisine: 'Brasileira',
	                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
	                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
	    Recipe.create(user: user, title: 'Macarronada', difficulty: 'Médio',
	                  recipe_type: another_recipe_type, cuisine: 'Brasileira',
	                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
	                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      get api_v1_recipe_type_path(recipe_type.id)
      json_recipe = JSON.parse(response.body, symbolize_names: true)

      expect(response.status). to eq 200
      expect(response.body).to include 'Sobremesa'
	    expect(response.body).not_to include 'Macarronada'
	    expect(response.body).to include 'Pudim'
	    expect(response.body).to include 'Quindim'
    end
end
