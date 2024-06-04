Rails.application.routes.draw do
  devise_for :users
  get '/mypage', to: 'users#mypage', as: 'mypage'
  resources :users, except: [:new, :create]
  get 'homes/top'
  get 'homes/about'
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :follows, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :favorites, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :comments, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  # トップページのルーティング
  root to: 'homes#top'
   # aboutページのルーティング
  get '/about', to: 'homes#about'  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
