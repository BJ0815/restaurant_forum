Rails.application.routes.draw do
  #Devise 自動建立認證使用者功能
  devise_for :users

  #前台路由設定的餐廳資源(只限定開放閱覽功能)
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
  end

  resources :categories, only: [:show]
  root "restaurants#index"

  #後台路由設定的餐廳資源(resources會開放7種action)
  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end

end
