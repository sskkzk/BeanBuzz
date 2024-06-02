Rails.application.routes.draw do
  get 'homes/top'
  get 'homes/about'
  devise_for :users
  resource :posts
  resource :follows
  resource :favorites
  resource :comments
  # トップページのルーティング
  root to: 'homes#top'
   # aboutページのルーティング
  get 'home/about', to: 'homes#about'  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
