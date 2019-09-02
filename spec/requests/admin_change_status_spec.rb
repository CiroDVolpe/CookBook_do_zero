require 'rails_helper'

  describe 'Admin change status' do
    it 'to accepted successfully'do
      user = User.create(email: 'email@email.com', password: '123456', admin: true)
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create!(user: user, title: 'Bolo de Cenoura', difficulty: 'Médio',
                              recipe_type: recipe_type, cuisine: 'Brasileira',
                              cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 0,
                              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      sign_in user
      post "/api/v1/recipes/#{recipe.id}/accepted"

      expect(response.status).to eq 202
      expect(response.body).to include("A receita #{recipe.title} foi aceita!")
    end
    it 'and to rejected successfully'do
      user = User.create(email: 'email@email.com', password: '123456', admin: true)
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create!(user: user, title: 'Bolo de Cenoura', difficulty: 'Médio',
                              recipe_type: recipe_type, cuisine: 'Brasileira',
                              cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 0,
                              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      sign_in user
      post "/api/v1/recipes/#{recipe.id}/rejected"

      expect(response.status).to eq 200
      expect(response.body).to include("A receita #{recipe.title} foi rejeitada!")
      end

    it 'and don`t reject if recipe does not exist 'do

      post "/api/v1/recipes/000/rejected"

      expect(response.status).to eq 404
      expect(response.body).to include("Receita não encontrada.")
    end

    it 'and don`t accept if recipe does not exist 'do

      post "/api/v1/recipes/000/accepted"

      expect(response.status).to eq 404
      expect(response.body).to include("Receita não encontrada.")
    end

    it 'and must be an admin to accept' do
      user = User.create(email: 'email@email.com', password: '123456', admin: false)
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create!(user: user, title: 'Bolo de Cenoura', difficulty: 'Médio',
                              recipe_type: recipe_type, cuisine: 'Brasileira',
                              cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 0,
                              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      sign_in user
      post "/api/v1/recipes/#{recipe.id}/accepted"

      expect(response.status).to eq 401
      expect(response.body).to include("Acesso NEGADO!")
    end

    it 'and must be an admin to reject' do
      user = User.create(email: 'email@email.com', password: '123456', admin: false)
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create!(user: user, title: 'Bolo de Cenoura', difficulty: 'Médio',
                              recipe_type: recipe_type, cuisine: 'Brasileira',
                              cook_time: 50, ingredients: 'Farinha, açucar, cenoura', status: 0,
                              cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      sign_in user
      post "/api/v1/recipes/#{recipe.id}/rejected"

      expect(response.status).to eq 401
      expect(response.body).to include("Acesso NEGADO!")
    end

  end
