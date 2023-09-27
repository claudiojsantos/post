Rails.application.routes.draw do
  post '/login', to: 'authentications#login'

  resources :postagens, only: %i[index show create update destroy]
  resources :comentarios, only: %i[index show create]
  resources :users, only: %i[index show create update destroy]
end
