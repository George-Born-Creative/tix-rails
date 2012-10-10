Tix::Application.routes.draw do
  match '/manager', :controller => :manager, :action => :index
  
  resources :pages, :path => '/', :controller => 'Front::Pages', :as => "front_pages", :only => [:show]
  
  # root :to => "pages#show", :controller => 'Front::Pages'
  # match '/', :controller => 'Front::Pages', :action => :show

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
    resources :widgets
    get "/images/tags" => "images#tags", :as => :tags
    resources :images
    
    
    get '/customers' => 'users#index'
    get '/newsletter' => 'newsletter#index'  
    
    # and finally,
    match '/:action', :controller => :manager

  end

  scope '/api' do
    resources :events
    resources :artists
    resources :orders
    resources :tickets, :only => [:create]
    
    match '/stats/:action', :controller => :stats
    
    get '/ticket_locks.json/new' => "ticket_locks#new"
    get '/ticket_locks.json/delete' => "ticket_locks#destroy"
    post '/ticket_locks.json/new' => "ticket_locks#new"
    post '/ticket_locks.json/delete' => "ticket_locks#destroy"
  end
  
  
  scope '/admin' do
    match '/', :controller => :admin, :action => :index
    resources :accounts  
  end
  
  
  resources :events, :as => 'front_events', :only => [:index, :show], :controller => 'Front::Events'
  # resources :artists, :as => 'front_artists', :only => [:index, :show]
  resources :orders, :as => "front_orders", :only => [:create, :show, :new], :controller => 'Front::Orders'
  resources :charts, :as => "front_charts", :only => [:show], :controller => 'Front::Charts'
  resources :pages, :as => "front_pages", :only => [:show], :controller => 'Front::Pages'
  
  
  match "/delayed_job" => DelayedJobWeb, :anchor => false
  
  # mount Resque::Server.new, :at => "/resque"
  
  mount Ckeditor::Engine => "/ckeditor"
  
  
end
