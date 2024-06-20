Rails.application.routes.draw do
  # 管理者設定
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    
    resources :users, only: [:destroy] # ここを追加
  end

  # ユーザー認証
  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords'
  }

  scope module: :public do
    get '/mypage', to: 'users#mypage', as: 'mypage'
    get 'homes/top', as: 'homes_top'
    get 'homes/about', as: 'homes_about'

    resources :posts do
      resources :comments, only: [:new, :create, :edit, :update, :destroy]
    end

    resources :users, only: [:index, :show, :edit, :update, :destroy]

    resources :follows, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :favorites, only: [:index, :new, :create, :show, :edit, :update, :destroy]

    root to: 'homes#top'
    get '/about', to: 'homes#about', as: 'about'
  end
end

