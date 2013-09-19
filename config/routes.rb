require 'sidekiq/web'

Putne::Application.routes.draw do
  root "main#index"
  get "about" => "main#about"
  get "help" => "main#help"

  resources :users do
    get "secret_key" => "secret_key#index"
    post "secret_key/create"
    put "secret_key/reset"
  end
  
  resources :projects do
    post "commit_hook" => "projects#commit_hook"
    get "commit_hook_url" => "projects#commit_hook_url"

    resources :reports do
      get "branches" => "git#branches"
      get "commits" => "git#commits"
      
      get "files" => "metrics#files"
      get "file" => "metrics#file"
      
      get "classes" => "metrics#classes"
      get "klass" => "metrics#klass"

      get "methods" => "metrics#methods"
      get "method" => "metrics#method"

      get "churn" => "metrics#churn"
      get "complexity" => "metrics#complexity"
      get "duplicity" => "metrics#duplicity"
      get "smells" => "metrics#smells"

      get "timeline" => "metrics#timeline"
    end
  end

  get "projects/:id/settings" => "projects#settings"

  devise_for :users
  
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount Sidekiq::Web, at: "/sidekiq"

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
