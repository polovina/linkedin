Linkedin::Application.routes.draw do
  resources :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :shots
  resources :boars
  resources :hunters
  resources :tasks
  resources :streams
  match "/auth" => "auth#index"
  match "/auth/callback" => "auth#callback"
  match "/auth/outlook" => "auth#outlook"
  match "/auth/check" => "auth#check"
  match "/hunters/:id/toggle" => "hunters#toggle"
  match "/hunters/check" => "hunters#check"
  match "/hunters/new" => "hunters#new"
  match "/hunters" => "hunters#index"
  match "/boars/:id/toggle" => "boars#toggle"
  match "/boars/:id/edit" => "boars#edit"
  match "/boars" => "boars#index"
  match "/boars/csv_import" => "boars#csv_import"
  match "/upload/index" => "upload#index"
  match "/upload/" => "upload#uploadFile"
  match "/shots/task_stream" =>"shots#task_stream"
  match "/shots/task_search" =>"shots#task_search"
  
  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'tasks#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
