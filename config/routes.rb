# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do

  post '/api', to: 'api_keys#create'
  delete '/api', to: 'api_keys#destroy'
  get '/api', to: 'api_keys#index'

  get '/api/user', to: 'api_keys#user_details'
  get '/api/time_slots', to: 'api_keys#time_slots'
  get '/api/meetings', to: 'api_keys#meetings'
  get '/api/meeting', to: 'api_keys#meeting'


  resources :meetings, only: [:index, :show, :new, :create, :destroy] do
    resources :messages, only: [:create]
  end

  resources :slots
  root to: 'main#index'

  get 'meeting/searchDate', to: 'meetings#searchDate', as: :search_date
  # GET /about
  get 'about', to: 'about#index'

  get 'profile', to: 'profiles#edit', as: :edit_profile
  patch 'profile', to: 'profiles#update'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'

  # get 'user/photos', to: 'photos#index'

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

end