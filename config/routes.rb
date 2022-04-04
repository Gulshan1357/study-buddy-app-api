# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: 'main#index'
  # GET /about
  get 'about', to: 'about#index'

  get 'profile', to: 'profiles#edit', as: :edit_profile
  patch 'profile', to: 'profiles#update'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

end
