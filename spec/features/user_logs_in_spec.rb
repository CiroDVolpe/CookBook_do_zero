require 'rails_helper'  
feature 'user logs in' do
  scenario 'successifully' do
    #arrange
    user = User.create!(email: 'user@mail.com', password: '1234567')
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '1234567'
      click_on 'Entrar'
    end
    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content("Olá, #{user.email}!")
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
  end

  scenario 'and logs out successifully' do
    #arrange
    user = User.create!(email: 'user@mail.com', password: '1234567')

    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '1234567'
      click_on 'Entrar'
    end
    click_on 'Sair'

    #assert
    expect(current_path).to eq root_path
    expect(page).not_to have_content("Olá, #{user.email}!")
    expect(page).not_to have_link('Sair')
    expect(page).to have_link('Entrar')
  end
end

