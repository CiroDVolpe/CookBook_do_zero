require 'rails_helper'

feature 'Visitor search recipe by ' do
  scenario 'full type succesfully' do
    #arrange
    user = User.create(email: 'batata@batato.com', password: 'batatinha')
    recipe_type = RecipeType.create(name:'Entrada')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           user: user, cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Bolo de abacaxi', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           user: user, cook_time: 60,
                           ingredients: 'Farinha, açucar, abacaxi',
                           cook_method: 'Corte o abacaxi em pedaços pequenos, misture com o restante dos ingredientes')
    
    #act
    visit root_path
    fill_in 'Título de Busca', with: 'Bolo de cenoura'
    click_on 'Buscar'

    #assert
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).not_to have_content('Bolo de abacaxi')
  end

  scenario 'full title and not find' do
    #arrange
    user = User.create(email: 'batata@batato.com', password: 'batatinha')
    recipe_type = RecipeType.create(name:'Entrada')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           user: user, cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Bolo de abacaxi', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           user: user, cook_time: 60,
                           ingredients: 'Farinha, açucar, abacaxi',
                           cook_method: 'Corte o abacaxi em pedaços pequenos, misture com o restante dos ingredientes')
    
    #act
    visit root_path
    fill_in 'Título de Busca', with: 'Bolo de chocolate'
    click_on 'Buscar'

    #assert
    expect(page).not_to have_content('Bolo de cenoura')
    expect(page).not_to have_content('Bolo de abacaxi')
    expect(page).to have_content('Receita não encontrada')
  end
  scenario 'partial title and find more than one' do
    #arrange
    user = User.create(email: 'batata@batato.com', password: 'batatinha')
    recipe_type = RecipeType.create(name:'Entrada')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           user: user, cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Bolo de abacaxi', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           user: user, cook_time: 60,
                           ingredients: 'Farinha, açucar, abacaxi',
                           cook_method: 'Corte o abacaxi em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(title: 'Risoto de cogumelo', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           user: user, cook_time: 60,
                           ingredients: 'Farinha, açucar, abacaxi',
                           cook_method: 'Corte o abacaxi em pedaços pequenos, misture com o restante dos ingredientes')
    #act
    visit root_path
    fill_in 'Título de Busca', with: 'Bolo'
    click_on 'Buscar'

    #assert
    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h1', text: 'Bolo de abacaxi')
  end
end
