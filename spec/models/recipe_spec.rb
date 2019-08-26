require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it { is_expected.to have_db_column(:title).of_type(:string) }
  #it { is_expected.to have_db_column(:recipe_type).of_type(:string) }
  it { is_expected.to have_db_column(:cuisine).of_type(:string) }
  it { is_expected.to have_db_column(:difficulty).of_type(:string) }
  it { is_expected.to have_db_column(:cook_time).of_type(:integer) }
  it { is_expected.to have_db_column(:ingredients).of_type(:text) }
  it { is_expected.to have_db_column(:cook_method).of_type(:text) }

  describe '#owner?' do
    it 'true' do
      user = User.create(email:'batato@batato.com', password: 'potato')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    user: user, cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

      result = recipe.owner?(user)
      
      expect(result).to eq true
    end
        
    it 'false' do
      user = User.create(email:'batato@batato.com', password: 'potato')
      user_other = User.create(email:'batata@batato.com', password: 'potato')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    user: user, cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
  
      result = recipe.owner?(user_other)
      
      expect(result).to eq false
    end

    it 'nil' do
      user = User.create(email:'batata@batato.com', password: 'potato')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    user: user, cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

        result = recipe.owner?(nil)
        expect(result).to eq false
    end

    it 'number' do 
      user = User.create(email:'batata@batato.com', password: 'potato')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    user: user, cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

        result = recipe.owner?(1)
        expect(result).to eq false
    end

      it 'array' do
      user = User.create(email:'batata@batato.com', password: 'potato')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: 'Brasileira',
                    user: user, cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

        result = recipe.owner?([user])
        expect(result).to eq false
      end
  end
end
