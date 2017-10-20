Rails.application.routes.draw do

  root 'static_pages#home'

  get "/products/category/", to: "products#by_category", as: 'products_by_category'

  resources :products do
    resources :reviews, only: [:new, :create]
    resources :order_items, only: [:new, :create]
  end

  resources :carts, except: [:destroy, :index, :new]
  resources :users, only: [:index, :show, :edit, :update]

  resources :reviews, except: [:new, :create]

  resources :orders

  get '/login', to: 'sessions#login_form', as: 'login'
  post '/login', to: 'sessions#login'
  post '/logout', to: 'sessions#logout', as: 'logout'

  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
