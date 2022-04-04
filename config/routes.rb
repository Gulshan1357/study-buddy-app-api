# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: 'main#index'
  # GET /about
  get 'about', to: 'about#index'

end
