Website::Application.routes.draw do
  resources :guestbooks, path: 'gaestebuch'
  post '/gaestebuch/manage' => 'guestbooks#manage'


  devise_for :users
  devise_scope :user do
    get   '/login' => 'devise/sessions#new'
    get   '/logout' => 'devise/sessions#destroy'
  end
  
  resources :users
  match '/profile' => 'users#profile'
  match '/profile/role/:id' => 'users#profile_role', as: :profile_role
  match '/dashboard' => 'users#dashboard', as: :dashboard

  resources :locations, path: 'spielorte'


  resources :teams
  resources :team_memberships

  resources :events

  resources :groups, path: 'gruppen'
  resources :group_memberships

  resources :pages, path: 's', constraints: { id: /[0-9]*/ } do
    resources :page_files
    member do
      get 'images.:format' => 'pages#images'
      get 'links.:format' => 'pages#links'
    end
  end
  get '/s/*path' => 'pages#show_by_path', as: :human_page
  
  resources :members, path: 'mitglieder'
  get '/mitglieder(::flags)' => 'members#index', as: :flagged_members
  
  resources :projects, path: 'projekte' do
    # collection do
    #   get '(::tags)' => 'projects#index', as: :tagged_projects
    #   get '(::tags)/:id' => 'projects#show', as: :show_tagged_project
    # end
    resources :project_files do
      collection do
        post ':kind' => 'project_files#create', as: 'specific'
      end
    end
    
    resources :members, path: 'darsteller', only: :show
  end
  
  get '/projekte(::tags)' => 'projects#index', as: :tagged_projects
  get '/projekte(::tags)/:id' => 'projects#show', as: :show_tagged_project


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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
