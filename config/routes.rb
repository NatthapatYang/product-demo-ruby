Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products
  resources :orders

  # new_product_path //POST create
  # edit_product_path(:id) //PATCH update
  # product_path(:id) //GET, DELETE can read and delete
  # products_path //GET can read all

  # get "/test/products" => "products#test"
  # get "/products" => "products#index"
  # get "/products/:id" => "products#show"
  # get "/products/new" => "products#new"
  # post "/products" => "products#create"


  # Defines the root path route ("/")
  # root "posts#index"
end
