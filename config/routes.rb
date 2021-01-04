Rails.application.routes.draw do
  resources :contact_requests
  resources :my_cards
  post '/auth/login', controller: :authentication, action: :login
end
