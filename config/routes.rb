Tix::Application.routes.draw do

  match '/manager', :controller => :manager, :action => :index
  get '/tickets/:id/checkin' => 'Front::Tickets#checkin', :as => 'ticket_checkin'
  
  # resources :pages, :path => '/', :controller => 'Front::Pages', :as => "front_pages", :only => [:show, :index]
  
  # root :to => "pages#show", :controller => 'Front::Pages'
  
  post '/users/user_env' => 'Front::Users#user_env'
  post '/users/login_env' => 'Front::Users#login_env'
  get '/users/my_account' => 'Front::Users#my_account'
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  resources :users, :controller => 'Front::Users', :as => 'front_users'
  resources :orders, :as => "front_orders", :only => [:index, :create, :show], :controller => 'Front::Orders'
  resources :addresses, :as => "front_addresses", :controller => 'Front::Addresses'
  resources :phones, :as => "front_phones",  :controller => 'Front::Phones'
  #end
  
  
  resources :checkouts, :as => 'front_checkouts', :only => [:show, :new, :create], :controller => 'Front::Checkouts'
  match '/orders/add_to_cart/:area_id', :controller => 'Front::Orders', :action => 'add_to_cart'
  match '/orders/remove_from_cart/:area_id', :controller => 'Front::Orders', :action => 'remove_from_cart'
  resources :charts, :as => "front_charts", :only => [:show], :controller => 'Front::Charts'
  match "/delayed_job" => DelayedJobWeb, :anchor => false
  mount Ckeditor::Engine => "/ckeditor"
  resources :events, :as => 'front_events', :only => [:index, :show], :controller => 'Front::Events'
  
  
  match '/page/:slug', :action => :show, :controller => 'Front::Pages'
  match '/page/:id/edit', :action => :edit, :controller => 'Pages'
  
  #  match '/cat/:slug', :controller => :cms, :action => :cat, :controller => 'Front::Pages'
  
  scope '/manager' do
    
    
   get '/reports' => 'reports#index'
   get '/reports/event_guestlist/:event_id' => 'reports#event_guestlist'
   get '/reports/event_sales/:event_id' => 'reports#event_sales'
   get '/reports/sales_over_time' => 'reports#sales_over_time'

    
    
    resources :carousels do
      resources :carousel_items#, :as => :items
    end
    
    resources :events
    
    match '/', :controller => :manager, :action => :index
    
    resources :customer_imports
    
    resources :users
    
    get "/artists/search" => "artists#search", :as => :search
    
    resources :artists
    
    resources :tickets
    
    resources :orders
    get '/orders/:id/tickets' => 'orders#tickets'
    
    resources :charts
    get '/charts/:id/clone_for_event/:event_id' => 'charts#clone_for_event'

    resources :accounts
    
    resources :ticket_templates
    resources :newsletters
    resources :pages

    resources :prices
    resources :sections
    resources :areas
    
    resources :sidebars
    resources :widgets
    resources :widget_placements
    resources :sidebars
    post '/sidebars/:id/sort' => 'sidebars#sort'
    
    resources :widgets
    
    
    
    
    resources :themes
    post '/themes/:id/activate' => 'themes#activate'
      
    
    get "/images/tags" => "images#tags", :as => :tags
    resources :images
    
    
    get '/customers' => 'users#index'
    get '/newsletter' => 'newsletter#index'  
    
    # and finally,
    match '/:action', :controller => :manager

    
  end
  
  scope '/admin' do
    match '/', :controller => :admin, :action => :index, :via => :post,  :constraints => {:area_id => /^\d/}
    resources :accounts  
  end
  
  get '/checkout' => 'front::checkouts#new'
  post '/checkout' => 'front::checkouts#create'
  
  match '/', :controller => 'Front::Pages', :action => :show
  match '/:slug', :action => :show, :controller => 'Front::Pages', :as =>  "front_pages"
  resources :pages, :only => [:show], :controller => 'Front::Pages'
  
  
  
end
