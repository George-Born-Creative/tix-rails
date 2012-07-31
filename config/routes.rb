Tix::Application.routes.draw do


  devise_for :users

  root :to => "main#index"
  
  get '/newsletter' => 'newsletter#index'

  scope '/api' do
    resources :events
    resources :artists
    resources :artists
    resources :orders
    
    match '/stats/:action', :controller => :stats
    
    get '/ticket_locks.json/new' => "ticket_locks#new"
    get '/ticket_locks.json/delete' => "ticket_locks#destroy"
    post '/ticket_locks.json/new' => "ticket_locks#new"
    post '/ticket_locks.json/delete' => "ticket_locks#destroy"
  end
  
  
end
