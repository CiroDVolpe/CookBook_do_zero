require 'rails_helper'

	describe 'Delete recipe' do
	  it 'successfully' do
	    user = User.create!(email: 'email@email.com', password: '123456')
	    recipe_type = RecipeType.create!(name: 'Sobremesa')
	    recipe = Recipe.create!(user: user, title: 'Bolo de Cenoura', difficulty: 'Médio',
	                            recipe_type: recipe_type, cuisine: 'Brasileira',
	                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
	                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
	    other_recipe = Recipe.create!(user: user, title: 'Bolo de Chocolate', difficulty: 'Médio',
	                            recipe_type: recipe_type, cuisine: 'Brasileira',
	                            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
	                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')


	    delete "/api/v1/recipes/#{other_recipe.id}"

	    expect(response.status).to eq 200 #ok
	    expect(response.body).to include("A receita #{other_recipe.title} foi deletada.")
	    expect(Recipe.last.title).to eq recipe.title
	  end

	  it 'and recipe must exist' do

	    delete "/api/v1/recipes/0000"

	    expect(response.status).to eq 404 #not_found
	    expect(response.body).to include('Receita não encontrada.')
	  end
	end
