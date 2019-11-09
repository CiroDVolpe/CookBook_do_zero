require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = User.create(email: 'fulaninho@detal.com',  password: '123456')
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Cozinha', with: 'Arabe'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'


    # expectativas
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
    expect(page).to have_css('h2', text: "Receita enviada por #{user.email}")
  end

  scenario 'and must fill in all fields' do
    user = User.create(email: 'fulaninho@detal.com',  password: '123456')
    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Cozinha', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'and must be logged' do 
  
  #act
  visit root_path

  #assert
  expect(page).not_to have_link('Enviar uma receita')
  end

  scenario 'and must be logged in to access route ' do
    #arrange
    #act
    visit new_recipe_path
    #assert
    expect(current_path).to eq new_user_session_path
  end
end