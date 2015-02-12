Rails.application.routes.draw do
  devise_for :users
  resources :movies

get '/' =>'movies#index'
get '/search' =>'movies#search'
get '/show/:id' => 'movies#show'
match '/addToFav/:id' => 'movies#addToFav', :via => :get, :as => :add_to_fav
match '/addToSeen/:id' => 'movies#addToSeen', :via => :get, :as => :add_to_seen
match '/addTooSee/:id' => 'movies#addTo_to_see', :via => :get, :as => :add_to_see
match '/removeFromFav/:id' => 'movies#removeFromFav', :via => :get, :as => :delete_fav_list
match '/removeFromSeen/:id' => 'movies#removeFromSeen', :via => :get, :as => :delete_seen_list
match '/removeFromSee/:id' => 'movies#removeFrom_to_see', :via => :get, :as => :delete_see_list
match '/getFavList/:id' => 'movies#getFavList', :via => :get, :as => :get_fav_list
match '/getSeenList/:id' => 'movies#getSeenList', :via => :get, :as => :get_seen_list
match '/getToSeeList/:id' => 'movies#getToSeeList', :via => :get, :as => :get_tosee_list
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
