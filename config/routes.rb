Rails.application.routes.draw do
  resources :my_cards
  post '/auth/login', controller: :authentication, action: :login
end
