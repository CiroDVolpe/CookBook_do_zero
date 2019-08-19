require 'rails_helper'

  feature 'Visitor edit recipe' do
    scenario 'successfully' do
      recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: 'Sobremesa',
                           cuisine: 'Brasileira', difficulty: 'Médio',
                           cook_time: 60,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      visit root_path
      click_on 'Bolo de cenoura'
      click_on 'Editar Receita'
      fill_in 'Título', with: 'Tabule'
      fill_in 'Tipo de Receita', with: 'Entrada'
      fill_in 'Cozinha', with: 'Arabe'
      fill_in 'Dificuldade', with: 'Fácil'
      fill_in 'Tempo de Preparo', with: '45'
      fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
      fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
      click_on 'Enviar'

      expect(page).to have_css('h1', text: 'Tabule')
      expect(page).to have_css('h3', text: 'Detalhes')
      expect(page).to have_css('p', text: 'Entrada')
      expect(page).to have_css('p', text: 'Arabe')
      expect(page).to have_css('p', text: 'Fácil')
      expect(page).to have_css('p', text: "45 minutos")
      expect(page).to have_css('h3', text: 'Ingredientes')
      expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
      expect(page).to have_css('h3', text: 'Como Preparar')
      expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
    end
  end
