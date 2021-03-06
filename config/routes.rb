Rails.application.routes.draw do
  devise_for :users
  resources :movies

get '/' =>'movies#index'
get '/show/:id' => 'movies#show'
match '/search' => 'movies#search', :via => :get, :as => :search
post '/add_to',:to  => 'movies#add_to',as: 'add_to'
post '/remove_from',:to  => 'movies#remove_from',as: 'remove_from'
match '/get_to_fav/:id' => 'movies#get_to_fav', :via => :get, :as => :get_to_fav
match '/get_to_seen/:id' => 'movies#get_to_seen', :via => :get, :as => :get_to_seen
match '/get_to_see/:id' => 'movies#get_to_see', :via => :get, :as => :get_to_see

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
