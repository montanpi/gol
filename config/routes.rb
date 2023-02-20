Rails.application.routes.draw do
  get 'game', to: "game#index", as: "game"

  get "game/update_matrix", to: "game#update_matrix", as: "update_matrix"

  root 'pages#home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
