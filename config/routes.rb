Rails.application.routes.draw do
  root 'home#index'

  resources :users do
    collection do 
      get 'add_friend/:id', to: 'users#add_friend', as: 'add_friend'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:new, :create, :edit, :update, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
