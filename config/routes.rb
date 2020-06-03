Rails.application.routes.draw do
 
  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  post "favorites/:shop_id/create" => "favorites#create" # shop_idを入れ、お気に入り登録の識別をする。
  delete "favorites/:shop_id/destroy" => "favorites#destroy"

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
