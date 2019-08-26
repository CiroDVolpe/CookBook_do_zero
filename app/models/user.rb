class User < ApplicationRecord
  has_many :recipes
  has_many :recipe_lists
  has_many :recipe_list_items, through: :recipe_lists
  has_many :item_recipes, through: :recipe_list_items, source: :recipes 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
