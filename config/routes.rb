ActionController::Routing::Routes.draw do |map|
  map.resources :deposits

  map.resources :deposit_types
  map.resources :accounts
  map.resource :user_session

  map.root :controller => "accounts", :action => "index"

#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'
end
