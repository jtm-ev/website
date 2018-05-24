# Constraint to catch old website links with ?nav= in it to redirect permanently
# module OldWebsiteConstraint
#   extend self

#   def matches?(request)
#     request.query_parameters.has_key?('nav')
#   end
# end

Website::Application.routes.draw do
  # resources :emails
  get '/email' => 'emails#new', as: :email
  post '/email' => 'emails#create'


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

  resources :locations, path: 'spielorte' do
    collection do
      put '/' => 'locations#manage'
    end
  end


  # resources :teams
  resources :team_memberships

  resources :events

  resources :groups, path: 'gruppen' do
    member do
      get 'adressen' => 'members#addresses', as: :address
    end
  end
  resources :group_memberships

  resources :pages, path: 's', constraints: { id: /[0-9]*/ } do
    resources :page_files
    member do
      get 'images.:format' => 'pages#images'
      get 'links.:format' => 'pages#links'
    end
  end
  get '/s/*path' => 'pages#show_by_path', as: :human_page

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
    resources :teams
  end

  get '/tools/:action' => 'tools'

  post '/project_files/:id/crop' => 'project_files#crop'

  get '/projekte(::tags)' => 'projects#index', as: :tagged_projects
  get '/projekte(::tags)/:id' => 'projects#show', as: :show_tagged_project




  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end


  #########################################################################
  # Static Website Stuff
  #########################################################################

  get 'datenschutz' => 'home#datenschutz'

  # #########################################################################
  # # Handling old Website Links
  # #########################################################################
  # match "/" => 'old_website#redirect', constraints: OldWebsiteConstraint
  # match "/phpThumb/*path" => 'old_website#redirect_image'

  # get "/sitemap.:format" => 'home#sitemap'
  root :to => 'home#index'

end
