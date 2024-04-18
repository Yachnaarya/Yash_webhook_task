Rails.application.routes.draw do
  resources :webhooks, only: [:create, :index, :show, :destroy]
  post "/webhooks/:source", to: "webhooks#create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
