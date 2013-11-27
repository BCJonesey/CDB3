CDB3::Application.routes.draw do
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
  get "main/index"
  root :to => 'main#index'
resource :session, :only => [:create]
  get 'session/logout' => 'sessions#destroy', :as => 'destroy_sessions'

  match 'main/login', :as => 'login', via: [:get]
  match 'main/logout', :as => 'logout', via: [:get, :post]

  resources :users
  
  resources :games do
    resources :members
    resources :characters do
      get 'character_version',:on => :member
    end
    resources :skills do
      put 'add_tag', :on => :member
      put 'remove_tag', :on => :member
    end
    resources :events do
      get 'registration_buttons',:on => :member
    end
    resources :character_skills
    resources :currencies
    resources :registrations
    resources :awards do
      get 'approve',:on => :member
      get 'assign',:on => :member
      post 'request_award', :on => :collection
    end
    resources :tags
  end
end
