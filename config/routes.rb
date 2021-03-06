Rails.application.routes.draw do
  get 'update/points'

  root 'welcome#index'

  get '/owners/:id' => 'welcome#owners', as: 'owner'
  get '/fixtures' => 'welcome#fixtures'
  get '/sidebets' => 'welcome#sidebets'

  get '/async_fixtures' => 'welcome#async_fixtures'

  get '/eric_console' => 'welcome#eric_console'
  get '/fixture_console' => 'welcome#fixture_console'

  post '/update/points' => 'update#points'
  post '/update/goals' => 'update#goals'
  post '/update/champ' => 'update#champ'
  post '/update/avatar/:id' => 'update#avatar'
  post '/update/avatar_list' => 'update#avatar_list'
  post '/update/special' => 'update#special'

  get '/test' => 'welcome#test'

  # testing

  # resources :users

  # get '/signup' => 'users#new'
  # post '/users' => 'users#create'

  # get 'create_club_data' => 'welcome#create_club_data'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
