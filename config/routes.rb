Tix::Application.routes.draw do

  devise_for :users

  root :to => "cms#index"
  
  match '/page/:slug', :controller => :cms, :action => :index
  
  resources :tickets
  get '/tickets/:id/checkin' => 'tickets#check_in'
  
  
  scope '/manager' do
    match '/', :controller => :manager, :action => :index
    
    resources :customer_imports
    
    resources :users
    resources :events
    resources :artists
    
    resources :orders
    get '/orders/:id/tickets' => 'orders#tickets'
    
    resources :charts
    post '/charts/:id/clone_for_event/:event_id' => 'charts#clone_for_event'

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
  
  match "/delayed_job" => DelayedJobWeb, :anchor => false
  
  # mount Resque::Server.new, :at => "/resque"
  
  mount Ckeditor::Engine => "/ckeditor"
  
  
end
