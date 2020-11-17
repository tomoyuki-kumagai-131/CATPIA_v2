Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  get 'messages/destroy'
  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'recruit_login' => 'sessions#recruit_login' # かんたんログインページ https://cat-pia.com/recruit_login/
  get 'rank' => 'shops#rank' # ランキング機能
  get 'mapindex' => 'shops#mapindex' # 地図一覧表示機能
  get 'random' => 'shops#random' # ランダム表示機能
  get 'introduce' => 'shops#introduce'
  post 'login' => 'sessions#create'
  post '/static_pages/guest_sign_in' => 'static_pages#new_guest'
  delete 'logout' => 'sessions#destroy'
  resources :users do  # フォロー機能について追記
    member do
      get :following, :followers
    end
  end
  # collection...全体のデータにアクセスする際に使用 resources以外のアクション
  resources :shops # IDがあるかないかで決定される
  resources :relationships, only: [:create, :destroy] # create・destroyアクションのルーティング追記
  get :favorites, to: 'favorites#index' # お気に入り一覧表示アクション
  post   "favorites/:shop_id/create"  => "favorites#create" # shop_idを入れ、お気に入り登録の識別をする
  delete "favorites/:shop_id/destroy" => "favorites#destroy"
  resources :comments, only: [:create, :destroy] # Commentsコントローラ・create・destroyアクション追記
  resources :notifications, only: :index # Notificationsコントローラ追記
  resources :messages, only: [:create, :destroy] # Messagesコントローラ追記
  resources :rooms, :only => [:create, :show, :index] # Roomsコントローラ追記
end
