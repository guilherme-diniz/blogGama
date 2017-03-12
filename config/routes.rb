Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
 match "signout", to: "sessions#destroy", via: [:get, :post]

 scope '/admin' do
    get '/', controller: :posts, action: :list
    get '/posts/list', controller: :posts, action: :list
    get '/posts/new', controller: :posts, action: :new
    get '/posts/edit/:id', controller: :posts, action: :edit, as: 'edit'
    post '/posts/delete/:id', controller: :posts, action: :destroy, as: 'destroy'
    post '/posts/create', controller: :posts, action: :create
    post '/posts/update/:id', controller: :posts , action: :update, as: 'update'
  end


  # Example resource route (maps HTTP verbs to controller actions automatically):
    namespace :posts do
      get '/' , action: :index
      get '/index' , action: :index
      get '/:id', action: :show , as: 'show'
    end

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
