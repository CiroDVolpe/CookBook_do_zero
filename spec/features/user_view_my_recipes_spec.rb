require 'rails_helper'
  
feature 'User view my recipes' do 
  scenario 'successifully' do 
    #arrange
    user = User.create(email: 'batata@batato.com', password: 'potato')
    other_user = User.create(email: 'batato@batata.com', password: 'potato')
    recipe_type = RecipeType.create(name: 'Entrada')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                          cuisine: 'Brasileira', difficulty: 'Médio',
                          user: user, cook_time: 60,
                          ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Bolo de abacaxi', recipe_type: recipe_type,
                          cuisine: 'Brasileira', difficulty: 'Médio',
                          user: user, cook_time: 60,
                          ingredients: 'Farinha, açucar, abacaxi',
                          cook_method: 'Cozinhe abacaxi, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Bolo de batata', recipe_type: recipe_type,
                          cuisine: 'Brasileira', difficulty: 'Médio',
                          user: other_user, cook_time: 60,
                          ingredients: 'Farinha, açucar, batata',
                          cook_method: 'Cozinhe a batata, corte em pedaços pequenos, misture com o restante dos ingredientes e se interne')
    
    #act
    visit root_path
    click_on 'Entrar'
    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'potato'
      click_on 'Entrar'
    end
    click_on 'Minhas Receitas'

    #assert
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Bolo de abacaxi')
    expect(page).not_to have_content('Bolo de batata')
  end

  scenario 'and has no recipes' do 
    #arrange
    user = User.create(email: 'batata@batato.com', password: 'potato')
    other_user = User.create(email: 'batato@batata.com', password: 'potato')
    recipe_type = RecipeType.create(name: 'Entrada')
    Recipe.create(title: 'Bolo de batata', recipe_type: recipe_type,
                          cuisine: 'Brasileira', difficulty: 'Médio',
                          user: other_user, cook_time: 60,
                          ingredients: 'Farinha, açucar, batata',
                          cook_method: 'Cozinhe a batata, corte em pedaços pequenos, misture com o restante dos ingredientes e se interne')
    
    #act
    visit root_path
    click_on 'Entrar'
    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: 'potato'
      click_on 'Entrar'
    end
    click_on 'Minhas Receitas'

    #assert
    expect(page).to have_content('Você ainda não possui nenhuma receita')
    expect(page).to have_link('Clique aqui para criar')
    expect(page).not_to have_content('Bolo de batata')
  end

  scenario 'and must be loged in' do
    #arrange
    
    #act
    visit my_recipes_path

    #assert
    expect(current_path).to eq new_user_session_path
    
  end
end
