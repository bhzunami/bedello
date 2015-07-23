Bedello::Application.routes.draw do
  resources :products
  resources :categories
  resources :users
  resources :orders do
    post "order"
    post "pay"
    post "deliver"
    post "complete"
    post "archive"
    get "postfinance", to: 'orders#postfinance'
  end
  resources :payments
  resources :shipments
  resources :properties
  resources :website_settings, only: [:show, :edit, :update]

  resources :carts, only: [:index]
  resources :sessions, only: [:new, :create, :destroy]

# Login system
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/login', to: 'sessions#new', via: 'get'

#Password reset
  get "/password_reset", to: 'users#show_password_reset', as: :password_reset
  post "/password_reset", to:'users#password_reset'
  get "/edit_password_reset/:id", to: 'users#edit_password_reset', as: :edit_password_reset
  post "/update_password_reset/:id", to: 'users#update_password_reset'

# Ajax Cart
  post "/cart/products", to: 'carts#products'

  #Admin
  get "/allProducts", to: 'products#indexAllProducts'

# Ajax Order
  post '/orders/createNewOrder', to: 'orders#createNewOrder'
  post '/products/checkQuantity', to: 'products#checkQuantity'

  match '/archived_orders', to: 'orders#archived_orders', via: 'get'

  #static pages

  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/agb", to: "static_pages#agb"

  root 'static_pages#home'

end
