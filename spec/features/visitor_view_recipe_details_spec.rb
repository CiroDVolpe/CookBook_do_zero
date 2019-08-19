require 'rails_helper'


  feature 'Visitor visit details' do
    scenario 'successfully' do
      recipe_type = RecipeType.create(name:'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type ,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      visit root_path
      click_on recipe.title

      expect(page).to have_css('h1', text: recipe.title)
      expect(page).to have_css('h3', text: 'Detalhes')
      expect(page).to have_css('p', text: recipe.recipe_type.name)
      expect(page).to have_css('p', text: recipe.cuisine)
      expect(page).to have_css('p', text: recipe.difficulty)
      expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")
      expect(page).to have_css('h3', text: 'Ingredientes')
      expect(page).to have_css('p', text: recipe.ingredients)
      expect(page).to have_css('h3', text: 'Como Preparar')
      expect(page).to have_css('p', text: recipe.cook_method)
  end

  feature 'and return to Recipe List' do
    scenario 'successfully' do
      recipe_type = RecipeType.create(name:  'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
      visit root_path
      click_on recipe.title
      click_on 'Voltar'

      expect(current_path).to eq(root_path)

    end
  end

end
