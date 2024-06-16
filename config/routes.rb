Rails.application.routes.draw do
  devise_for :users

  get '/mypage', to: 'users#mypage', as: 'mypage'
  resources :users, except: [:new, :create]

  get 'homes/top'
  get 'homes/about'

  resources :posts do
    resources :comments
  end

  resources :comments

  resources :follows, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :favorites, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  root to: 'homes#top'
  
  get '/about', to: 'homes#about'
end
