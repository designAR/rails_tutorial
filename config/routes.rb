Rails.application.routes.draw do
  
  get 'main', to: 'users#main'

  get 'sessions/new'
  get 'sessions/destroy'
  get 'pages/home'
  
  resources :users
  root 'pages#home'

  # 로그인
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'

end