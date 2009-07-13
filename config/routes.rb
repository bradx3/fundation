ActionController::Routing::Routes.draw do |map|
  map.resources :withdrawals
  map.resources :synchronize
  map.resources(:deposits, 
                :collection => { :accounts => :any })
  map.resources :deposit_templates
  map.resources :accounts
  map.resource :user_session

  map.connect "login", :controller => "user_sessions", :action => "new"

  map.root :controller => "accounts", :action => "index"

#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'
end
