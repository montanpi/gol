Rails.application.routes.draw do

  get "update_matrix", to: "pages#update_matrix", as: "update_matrix"

  root 'pages#home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
