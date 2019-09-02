require 'rails_helper'

	describe 'Admin post recipe type' do
	  it 'successfully' do
			user = User.create(email: 'email@email.com', password: '123456', admin: true)

			sign_in user
	    post "/api/v1/recipe_types", params: { recipe_type: { name: 'Sobremesa'}, user: { admin: true} }

	    expect(response.status).to eq 201 #created
	    expect(response.body).to include('Sobremesa')
	  end
	  it 'and must not be empty' do
			user = User.create(email: 'email@email.com', password: '123456', admin: true)

			sign_in user
	    post "/api/v1/recipe_types", params: { recipe_type: { name: ''}, user: { admin: true}  }

	    expect(response.status).to eq 412 #bad_request
	    expect(response.body).to include('Name Precisa ser Preenchido')
	  end
	  it 'and must be unique' do
	    recipe_type = RecipeType.create(name: 'Sobremesa')
			user = User.create(email: 'email@email.com', password: '123456', admin: true)

			sign_in user
			post "/api/v1/recipe_types", params: { recipe_type: { name: 'Sobremesa'}, user: { admin: true}  }

	    expect(response.status).to eq 412 #bad_request
	    expect(response.body).to include('Name Já existe')
	  end
		it 'and must be an admin' do
			user = User.create(email: 'email@email.com', password: '123456', admin: false)

			sign_in user
	    post "/api/v1/recipe_types", params: { recipe_type: { name: 'Sobremesa'}, user: {admin: false}  }

	    expect(response.status).to eq 401 #Unathorized
	    expect(response.body).to include('NEGADO')
	  end
		it 'and must not be visitor' do

	    post "/api/v1/recipe_types", params: { recipe_type: { name: 'Sobremesa'} }

	    expect(response.status).to eq 401 #Unathorized
	    expect(response.body).to include('NEGADO')
	  end

	end
