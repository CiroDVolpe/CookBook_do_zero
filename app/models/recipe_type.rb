class RecipeType < ApplicationRecord
  has_many :recipes

  validates :name, presence: {message: 'Precisa ser Preenchido'}
  validates :name, uniqueness: {message: 'Já existe'}
end
