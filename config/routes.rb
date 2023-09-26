Rails.application.routes.draw do
  post '/login', to: 'authentications#login'
end
