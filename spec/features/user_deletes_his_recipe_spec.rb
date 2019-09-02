require 'rails_helper'

  feature 'User delete recipe' do
    scenario 'successfully' do
    user  = User.create!(email: 'carinha@mail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: 'Brasileira',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user)

    visit root_path
    click_on 'Entrar'
    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Bolo de cenoura'
    click_on 'Deletar Receita'

    expect(page).not_to have_content('Bolo de cenoura')
    end

    scenario 'and cant find button to delete others recipes' do
    user  = User.create!(email: 'carinha@mail.com', password: '123456')
    other_user  = User.create!(email: 'email@mail.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: 'Brasileira',
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user)

    visit root_path
    click_on 'Entrar'
    within('.formulario') do
      fill_in 'Email', with: other_user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Bolo de cenoura'

    expect(page).not_to have_content('Deletar Receita')
    end
  end
