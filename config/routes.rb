Rails.application.routes.draw do
  #Devise 自動建立認證使用者功能
  devise_for :users

  #使用者profile頁面路由
  resources :users, only: [:show, :edit, :update]

  #前台路由設定的餐廳資源(只限定開放閱覽功能)
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    #集合路由(群集)
    collection do
      #瀏覽所有餐廳最新動態
      get :feeds
    end

    #成員路由(特定元素)
    member do
      #瀏覽個別餐廳的Dashboard
      get :dashboard

      #收藏/取消收藏
      post :favorite
      post :unfavorite
    end

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
