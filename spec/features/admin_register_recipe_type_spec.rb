require 'rails_helper'

feature 'Admin register recipe type' do 
  scenario 'succesfully' do
   
    # simula a ação do usuário
    visit root_path
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: 'Prato Principal'
    click_on 'Enviar'

    #expectativas
    expect(page).to have_css('h1', text: 'Prato Principal')

  end

  scenario 'and must fill in all fields' do
    #arrange

    #act
    visit root_path
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end

  scenario 'and must be unique' do
    #arrange
    RecipeType.create(name: 'Entrada')
    
    #act
    visit root_path
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: 'Entrada'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar o tipo de receita')
  end
end