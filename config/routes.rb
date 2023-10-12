Rails.application.routes.draw do
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  # get 'user/new' => "users#new"
  # post 'user/create' => "users#create"

  resources :users
end
