Rails.application.routes.draw do
 
  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # フォロー機能について追記
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :shops
  # create・destroyアクションのルーティング追記
  resources :relationships, only: [:create, :destroy]
end
