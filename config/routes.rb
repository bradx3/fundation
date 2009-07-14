ActionController::Routing::Routes.draw do |map|
  map.resources :withdrawals
  map.resources :synchronize
  map.resources(:deposits, 
                :collection => { :funds => :any })
  map.resources :deposit_templates
  map.resources :funds
  map.resource :user_session

  map.connect "login", :controller => "user_sessions", :action => "new"

  map.root :controller => "funds", :action => "index"

#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'
end
