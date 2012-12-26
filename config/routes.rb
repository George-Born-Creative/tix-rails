Tix::Application.routes.draw do
  
  match '/404', :to => 'errors#not_found'
  match '/422', :to => 'errors#server_error'
  match '/500', :to => 'errors#server_error'
  
  scope '/admin' do
    match '/', :controller => :admin, :action => :index
    resources :accounts  
  end

  match '/manager', :controller => :manager, :action => :index
  match '/static/:action', :controller => 'Front::Static'
  
  get '/tickets/:id/checkin' => 'Front::Tickets#checkin', :as => 'ticket_checkin'
  get '/orders/:id/checkin' => 'Front::Orders#checkin_tickets!', :as => 'order_checkin'
  
  post '/users/user_env' => 'Front::Users#user_env'
  post '/users/login_env' => 'Front::Users#login_env'
  
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, :controller => 'Front::Users', :as => 'front_users'
  
  get '/orders/success' => 'Front::Orders#success'
  get '/orders/:id/tickets' => 'Front::Orders#tickets'
  match '/orders/add_to_cart/:area_id', :controller => 'Front::Orders', :action => 'add_to_cart'
  match '/orders/remove_from_cart/:area_id', :controller => 'Front::Orders', :action => 'remove_from_cart'
  put '/orders', :controller => 'Front::Orders', :action => 'create'
  resources :orders, :as => "front_orders", :controller => 'Front::Orders'
  
  resources :addresses, :as => "front_addresses", :controller => 'Front::Addresses'
  resources :phones, :as => "front_phones",  :controller => 'Front::Phones'
  
  match "/delayed_job" => DelayedJobWeb, :anchor => false
  mount Ckeditor::Engine => "/ckeditor"

  resources :events, :as => 'front_events', :only => [:index, :show], :controller => 'Front::Events'
  get '/events/:id/seats' => 'Front::Charts#show', :as => 'front_chart'
  
  # For Jammin' Java redirects
  match '/home/events/:id' => redirect("/events/%{id}")
  match '/home/kids-events/list' => redirect("/kids-shows") 
  match '/home/kids-events/:id' => redirect("/events/%{id}")
  match '/home/main/home' => redirect("/") 
  match '/home/main/list' => redirect("/calendar") 
  match '/home/main/faq' => redirect("/faq") 
  match '/home/main/contact' => redirect("/contact") 
  match '/home/lobbybar' => redirect("/lobby-bar") 
    
  scope '/manager' do
   get '/reports' => 'reports#index'
   get '/reports/event_guestlist/:event_id' => 'reports#event_guestlist'
   get '/reports/event_sales/:event_id' => 'reports#event_sales'
   get '/reports/sales_over_time' => 'reports#sales_over_time'

    resources :gateways
    post '/gateways/:id/activate' => 'gateways#activate'
    
    
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
    
    resources :accounts
    
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
  
  match '/', :controller => 'Front::Pages', :action => :show
  match '/:slug', :action => :show, :controller => 'Front::Pages', :as =>  "front_pages"
  resources :pages, :only => [:show], :controller => 'Front::Pages'
  
  # rack_error_handler = ActionDispatch::PublicExceptions.new('public/')
  
  
end
