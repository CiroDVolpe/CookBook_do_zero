Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :recipes, only: %i[index show new create edit update ] do
    post 'add_to_list', on: :member
    delete 'remove_from_list', on: :member
  end
  resources :recipe_types, only: %i[new create show]
  resources :recipe_lists, only: %i[index show new create]

  get 'search', to: 'recipes#search'
  get 'my_recipes', to: 'recipes#my'

  namespace :api do
    namespace :v1 do
      resources :recipe_types, only: [:create, :show]
      resources :recipes, only: [:create, :destroy, :index] do
        post 'accepted', on: :member
        post 'rejected', on: :member
      end
    end
  end
end
