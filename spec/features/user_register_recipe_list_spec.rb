require 'rails_helper'

feature 'User register recipe list' do
  scenario 'successfully' do
    #arrange
    user  = User.create!(email: 'carinha@mail.com', password: '123456')
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Minhas Listas'
    click_on 'Enviar Lista'

    fill_in 'Nome da lista', with: 'Bons Drinks'
    click_on 'Enviar'

    #assert
    expect(page).to have_css('h1', text: 'Bons Drinks')
    expect(page).to have_css('h2', text: 'Esta lista ainda esta vazia')
    expect(page).to have_content('Voltar para listas')
  end
  scenario 'and must be unique' do
    #arrange
    user  = User.create!(email: 'carinha@mail.com', password: '123456')
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Minhas Listas'
    click_on 'Enviar Lista'
    fill_in 'Nome da lista', with: 'Bons Drinks'
    click_on 'Enviar'
    click_on 'Voltar para listas'
    click_on 'Enviar Lista'
    fill_in 'Nome da lista', with: 'Bons Drinks'
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível criar lista de receitas')
  end
end
