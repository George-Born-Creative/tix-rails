Tix::Application.routes.draw do

  root :to => "main#index"

  scope '/api' do
    resources :events
    get '/ticket_locks.json/new' => "ticket_locks#new"
    get '/ticket_locks.json/delete' => "ticket_locks#destroy"
    post '/ticket_locks.json/new' => "ticket_locks#new"
    post '/ticket_locks.json/delete' => "ticket_locks#destroy"
  end
  
  
end
