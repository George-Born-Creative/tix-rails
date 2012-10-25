Tix::Application.routes.draw do

  match '/manager', :controller => :manager, :action => :index
  
  # resources :pages, :path => '/', :controller => 'Front::Pages', :as => "front_pages", :only => [:show, :index]
  
  # root :to => "pages#show", :controller => 'Front::Pages'
  match '/', :controller => 'Front::Pages', :action => :show

  devise_for :users
  
  match '/page/:slug', :action => :show, :controller => 'Front::Pages'
  match '/page/:id/edit', :action => :edit, :controller => 'Pages'
  
  #  match '/cat/:slug', :controller => :cms, :action => :cat, :controller => 'Front::Pages'
  
  scope '/manager' do
    resources :events# , :as => 'manager_events'
    
    match '/', :controller => :manager, :action => :index
    get '/tickets/:id/checkin' => 'tickets#check_in'
    
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
    resources :reports
    resources :prices
    resources :sections
    resources :areas
    
    resources :sidebars
    resources :widgets
    resources :widget_placements
    resources :sidebars
    post '/sidebars/:id/sort' => 'sidebars#sort'
    
    resources :widgets
    resources :carousels
    resources :carousel_items
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
  
    
  resources :checkouts, :as => 'front_checkouts', :only => [:show, :new, :create], :controller => 'Front::Checkouts'
  
  resources :events, :as => 'front_events', :only => [:index, :show], :controller => 'Front::Events'
  # resources :artists, :as => 'front_artists', :only => [:index, :show]
  resources :orders, :as => "front_orders", :only => [:create, :show, :new], :controller => 'Front::Orders'
  
  match '/orders/add_to_cart/:area_id', :controller => 'Front::Orders', :action => 'add_to_cart'
  match '/orders/remove_from_cart/:area_id', :controller => 'Front::Orders', :action => 'remove_from_cart'
  
  resources :charts, :as => "front_charts", :only => [:show], :controller => 'Front::Charts'
  resources :pages, :as => "front_pages", :only => [:show], :controller => 'Front::Pages'
  
  
  match "/delayed_job" => DelayedJobWeb, :anchor => false
  
  # mount Resque::Server.new, :at => "/resque"
  
  mount Ckeditor::Engine => "/ckeditor"
  
  
end
