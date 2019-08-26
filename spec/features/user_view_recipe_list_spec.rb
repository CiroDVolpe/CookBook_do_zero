require 'rails_helper'

feature 'User view recipe list' do 
  scenario 'successfully' do
    user  = User.create!(email: 'carinha@mail.com', password: '123456')
    recipe_list = RecipeList.create(user: user, name: 'coisas gostosas')
    other_user  = User.create!(email: 'carinho@mail.com', password: '123456')
    other_recipe_list = RecipeList.create(user: other_user, name: 'coisas deliciosas')

    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Minhas Listas'

    expect(page).to have_css('h1', text: recipe_list.name)
    expect(page).not_to have_content('Você ainda não possui listas')
    expect(page).not_to have_content('coisas deliciosas')
  end
end