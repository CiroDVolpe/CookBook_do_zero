require 'rails_helper'

  describe 'User post recipes' do
    it 'successfully'do
      user  = User.create(email: 'carinha@mail.com', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')

      #act
      post "/api/v1/recipes", params: { recipe: { title: 'Bolo de cenoura', difficulty: 'Médio',
                                               recipe_type_id: recipe_type.id, cuisine: 'Brasileira',
                                               cook_time: 50, status: 1,
                                               ingredients: 'Farinha, açucar, cenoura',
                                               cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                               user_id: user.id} }
      #assert
      expect(response.status).to eq 201 #created
      expect(response.body).to include('Bolo de cenoura')
      expect(response.body).to include('Sobremesa')
      expect(response.body).to include('carinha@mail.com')
    end
    it 'and must fill all fields' do
	    #arrange
	    user  = User.create!(email: 'carinha@mail.com', password: '123456')
	    recipe_type = RecipeType.create(name: '')

	    #act
	    post "/api/v1/recipes", params: { recipe: { title: '', difficulty: '',
	                                                recipe_type_id: recipe_type.id, cuisine: '',
	                                                cook_time: 0, status: 1,
	                                                ingredients: '',
	                                                cook_method: '',
	                                                user_id: user.id} }

	    #assert
	    expect(response.status).to eq 412 #bad_request
	    expect(response.body).to include('Receita não cadastrada.')
	    expect(response.body).to include("Title can't be blank")
	  end

	  it 'and must have a user id' do
	    #arrange
	    recipe_type = RecipeType.create(name: 'Sobremesa')
	    #act
	    post "/api/v1/recipes", params: { recipe: { title: 'Bolo de cenoura', difficulty: 'Médio',
	                                                recipe_type_id: recipe_type.id, cuisine: 'Brasileira',
	                                                cook_time: 50, status: 1,
	                                                ingredients: 'Farinha, açucar, cenoura',
	                                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
	                                                user_id: ''} }

	    #assert
	    expect(response.status).to eq 412 #bad_request
	    expect(response.body).to include('Receita não cadastrada.')
	    expect(response.body).to include('User must exist')
	  end
  end
