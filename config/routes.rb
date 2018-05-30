Rails.application.routes.draw do
  root "posts#index"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
      member do
      get :following, :followers
      end
  end
  resources :posts
  resources :account_activations, only: [:edit]
  resources :relationships, only: [:create, :destroy]
end
