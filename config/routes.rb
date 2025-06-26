Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'hello/index' => 'hello#index'
  get 'hello/link' => 'hello#link'
  get 'hello/design' => 'hello#design'

  resources :users, only: [:show]
  resources :tweets do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :shops do
    resources :comments, only: [:create, :destroy] # コメントはshopに紐付くため、ネストする
  end
  resources :hashtags, only: [:show] # ハッシュタグの詳細ページ（ツイート一覧）
  root 'hello#index'

  # ルーレット機能を呼び出すためのルート
  get 'post/roulette', to: 'post#roulette', as: 'roulette_post'
  # 必要に応じて、ルートのルート（例: root 'post#roulette'）を設定することもできます。

  # Defines the root path route ("/")
  # root "posts#index"
end
