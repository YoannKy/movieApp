Rails.application.routes.draw do
  devise_for :users
  resources :movies

get '/' =>'movies#index'
get '/show/:id' => 'movies#show'
match '/search' => 'movies#search', :via => :get, :as => :search
post '/add_to_fav',:to  => 'movies#add_to_fav',as: 'add_to_fav'
match '/add_to_seen' => 'movies#add_to_seen', :via => :post, :as => :add_to_seen
post '/remove_from_fav',:to  => 'movies#remove_from_fav',as: 'remove_from_fav'
post '/remove_from_seen',:to  => 'movies#remove_from_seen',as: 'remove_from_seen'
match '/get_fav_list/:id' => 'movies#get_fav_list', :via => :get, :as => :get_fav_list
match '/get_seen_list/:id' => 'movies#get_seen_list', :via => :get, :as => :get_seen_list
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
