ActionController::Routing::Routes.draw do |map|
  map.resources :transactions
  map.resources :transfers

  map.resources(:users, 
                :collection => { :confirm => :get, :confirm_password => :put })

  map.resources :withdrawals
  map.resources(:synchronize, 
                :collection => { :start => :post })
  map.resources(:deposits, 
                :collection => { :funds => :any })
  map.resources :deposit_templates
  map.resources :funds
  map.resource :user_session

  map.connect "login", :controller => "user_sessions", :action => "new"

  map.root :controller => "funds", :action => "index"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
