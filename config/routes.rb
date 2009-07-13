ActionController::Routing::Routes.draw do |map|
  map.resources :deposits, :collection => { :accounts => :any }

  map.resources :deposit_types
  map.resources :accounts
  map.resource :user_session

  map.connect "login", :controller => "user_sessions", :action => "new"

  map.root :controller => "accounts", :action => "index"

#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'
end
