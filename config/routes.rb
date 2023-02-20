Rails.application.routes.draw do
  devise_for :users

  get 'game', to: 'game#index', as: 'game'
  get 'game/update_matrix', to: 'game#update_matrix', as: 'update_matrix'
  post 'home/upload'
  root 'home#index'
end
