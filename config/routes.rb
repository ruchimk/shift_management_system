Rails.application.routes.draw do

  post "/change_shift", to: 'requests#change_shift', as: 'change_shift'
  post "/make_shift_available", to: 'requests#make_shift_available', as: 'make_shift_available'
  patch "/pick_up_shift/:id", to: 'requests#pick_up_shift', as: :pick_up_shift
  patch "/give_shift/:id", to: 'requests#give_shift', as: :give_shift
  patch "/approve_shift/:id", to: 'requests#approve_shift', as: :approve_shift

  devise_scope :user do
    get '/signup', to: 'registrations#new'
    post '/new_user', to: 'registrations#create', as: :create_user
    get '/add_employee', to: 'registrations#new_employee', as: :new_employee
    post '/create_employee', to: 'registrations#create_employee', as: :create_employee
  end

  devise_for :users

  resources :requests

  get '/users/sign_in', to: 'sessions#create', as: 'login'

  get 'company/new'

  get 'welcome/dashboard'

  root "welcome#splash"

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
