Rails.application.routes.draw do
  get 'signup' => 'users#new'
  resources :users
  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
