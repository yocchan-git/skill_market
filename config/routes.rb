Rails.application.routes.draw do
  # get 'user/new' => "users#new"
  # post 'user/create' => "users#create"

  resources :users
end
