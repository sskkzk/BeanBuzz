Rails.application.routes.draw do
  devise_for :users
  
  # 管理者設定
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  

  get '/mypage', to: 'users#mypage', as: 'mypage'
  resources :users, except: [:new, :create]

  get 'homes/top'
  get 'homes/about'

  resources :posts do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end


  resources :comments, only: [:new, :create, :edit, :update, :destroy]


  resources :follows, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :favorites, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  root to: 'homes#top'
  
  get '/about', to: 'homes#about'
end
