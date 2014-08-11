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
  post "/products/listOfProducts", to: 'products#listOfProducts'
  get "/allProducts", to: 'products#allProducts'

# Ajax Order
  post '/orders/createNewOrder', to: 'orders#createNewOrder'
  post '/products/checkQuantity', to: 'products#checkQuantity'

  match '/archived_orders', to: 'orders#archived_orders', via: 'get'

  #static pages

    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get "/agb", to: "static_pages#agb"

    root 'static_pages#home'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
