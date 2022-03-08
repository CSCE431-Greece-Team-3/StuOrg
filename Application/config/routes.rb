Rails.application.routes.draw do
  get "/mem_profile", to: "members#show"
  get "/edit_mem", to: "members#edit"
  delete "/delete_member", to: "members#destroy"
  resources :members
  resources :products

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get "/", to: "articles#index"

  get "/add_potential_members", to: "users#add_members"
  post "/create_new_member", to: "users#create_new_member"
  get "/signup_organization", to: "users#new"
  get "/signup_member", to: "members#new"

  resources :users, only: [:new, :create, :update, :edit, :destroy, :show, :index]

  get "/welcome", to: "articles#welcome"

  get "/marketplace", to: "products#marketplace"

  get "/dashboard", to: "dashboards#dashboard"

  get "products", to: "articles#products"
  get "/view_members", to: "users#index"
  get "profile", to: "dashboards#dashboard"
  

  get "/checkout", to: "orders#index"

  get "upload", to: "products#new"
  post "upload", to: "products#create"

  get 'editprofile', to: "users#edit"

  delete 'deleteprofile', to: "users#destroy"
  delete '/', to: "sessions#destroy"

  post :create_order, :to => 'orders#create_order'
  post :capture_order, :to => 'orders#capture_order'

  get 'tags/:tag', to: 'products#tag_index', as: :tag



  resources :articles
  resources :member
  # post "/login", to: "articles#welcome"

  # post "userinfo", to: ""
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

