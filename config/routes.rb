Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  #ユーザ回りのルート
  devise_for :users

  resources :users, only: [:show]
 
  root 'infos#index' # 追記

  #新規投稿ページへのルーティング
  get 'infos/new' => 'infos#new'
  post 'infos' => 'infos#create'

  #投稿の詳細ページへのルーティング
  get 'infos/:id' => 'infos#show', as: 'info'

  #投稿の編集・削除へのルーティング
  patch 'infos/:id' => 'infos#update'
  delete 'infos/:id' => 'infos#destroy'
  get 'infos/:id/edit' => 'infos#edit', as: 'edit_info'

  #read_onlyへのルーティング /infos/read_only/:id
  get 'infos/read_only/:id' => 'infos#read_only', as: 'read_only_info'
  

   # エラーページをカスタムルートに設定
  #get "/500", to: "errors#internal_server_error"

end
