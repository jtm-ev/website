# Constraint to catch old website links with ?nav= in it to redirect permanently
module OldWebsiteConstraint
  extend self

  def matches?(request)
    request.query_parameters.has_key?('nav')
  end
end

Website::Application.routes.draw do




  ############################################################################
  # Login / Sessions
  ############################################################################
  devise_for :users
  devise_scope :user do
    get   '/login' => 'devise/sessions#new'
    get   '/logout' => 'devise/sessions#destroy'
  end

  ############################################################################
  # Intern
  ############################################################################
  get '/dashboard' => redirect('/i/dashboard')

  get '/email' => 'emails#new', as: :email
  post '/email' => 'emails#create'

  namespace :intern, path: 'i' do
    ### User
    resources :users do

    end

    ### Profile/Dashboard
    match '/profile' => 'users#profile'
    match '/profile/role/:id' => 'users#profile_role', as: :profile_role
    match '/dashboard' => 'users#dashboard', as: :dashboard


    ### Mitglieder
    resources :members, path: 'mitglieder' do
      collection do
        get 'adressen' => 'members#addresses', as: :address
      end
      member do
        get 'deactivate' => 'members#deactivate'
        get 'activate' => 'members#activate'
      end
    end
    get '/mitglieder(::flags)' => 'members#index', as: :flagged_members


    ### Gruppen
    resources :groups, path: 'gruppen' do
      member do
        get 'adressen' => 'members#addresses', as: :address
      end
    end
    resources :group_memberships

    ### Projekte
    resources :projects, path: 'projekte' do
      resources :project_files do
        collection do
          post ':kind' => 'project_files#create', as: 'specific'
        end
      end

      resources :teams
    end

  end


  ############################################################################
  # Extern
  ############################################################################
  resources :guestbooks, path: 'gaestebuch'
  post '/gaestebuch/manage' => 'guestbooks#manage'

  resources :members, path: 'mitglieder', only: [:show]   # public member profiles

  resources :projects, path: 'projekte', only: [:index, :show]
  get '/projekte(::tags)' => 'projects#index', as: :tagged_projects
  get '/projekte(::tags)/:id' => 'projects#show', as: :show_tagged_project

  resources :locations, path: 'spielorte' do
    collection do
      put '/' => 'locations#manage'
    end
  end

  resources :pages, path: 's', constraints: { id: /[0-9]*/ } do
    resources :page_files
    member do
      get 'images.:format' => 'pages#images'
      get 'links.:format' => 'pages#links'
    end
  end
  get '/s/*path' => 'pages#show_by_path', as: :human_page



  ############################################################################
  # UNKNOWN
  ############################################################################



  # resources :teams
  resources :team_memberships

  resources :events


  ### Image Cropper
  get '/tools/:action' => 'tools'
  post '/project_files/:id/crop' => 'project_files#crop'

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

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  #########################################################################
  # Handling old Website Links
  #########################################################################
  match "/" => 'old_website#redirect', constraints: OldWebsiteConstraint
  match "/phpThumb/*path" => 'old_website#redirect_image'

  get "/sitemap.:format" => 'home#sitemap'
  root :to => 'home#index'

end
