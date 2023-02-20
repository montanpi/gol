Rails.application.routes.draw do
  devise_for :users

  get 'game', to: 'game#index', as: 'game'

  get 'sse', to: 'sse#start', as: 'start_sse'
  get 'sse', to: 'sse#stop', as: 'stop_sse'

  post 'home/upload'
  root 'home#index'
end
