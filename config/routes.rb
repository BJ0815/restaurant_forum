Rails.application.routes.draw do
  #Devise 自動建立認證使用者功能
  devise_for :users

  #使用者profile頁面路由
  resources :users, only: [:index, :show, :edit, :update]
  #使用者追蹤使用者
  resources :followships, only: [:create, :destroy]

  #使用者的好友
  resources :friendships, only: [:create, :update, :destroy]
  
  #前台路由設定的餐廳資源(只限定開放閱覽功能)
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    #集合路由(群集)
    collection do
      #瀏覽所有餐廳最新動態
      get :feeds
      get :ranks
    end

    #成員路由(特定元素)
    member do
      #瀏覽個別餐廳的Dashboard
      get :dashboard

      #收藏/取消收藏
      post :favorite
      post :unfavorite

      #like / unlike
      post :like
      post :unlike
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
