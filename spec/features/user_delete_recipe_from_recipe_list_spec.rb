require 'rails_helper'

  feature 'User delete recipe from recipe list' do
    scenario 'successfully'do
    user  = User.create!(email: 'carinha@mail.com', password: '123456')
    recipe_list = RecipeList.create(user: user, name: 'coisas gostosas')
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
    select 'coisas gostosas', from: 'Listas'
    click_on 'Adicionar à Lista'
    click_on 'Minhas Listas'
    click_on 'coisas gostosas'
    click_on 'Apagar Receita'

    expect(page).to have_content('Esta lista ainda esta vazia')
    expect(page).not_to have_content('Bolo de cenoura')
    end
  end
