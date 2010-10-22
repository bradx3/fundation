Fundation::Application.routes.draw do
  resources :transactions
  resources :transfers
  resources :users do
    collection do
      get :confirm
      put :confirm_password
    end
  end

  resources :withdrawals

  resources :synchronize do
    collection do
      post :start
    end
  end

  resources :deposits do
    collection do
      get :funds
    end
  end

  resources :deposit_templates
  resources :funds
  resource :user_session
  resource :password_resets
  match 'login' => 'user_sessions#new'
  match '/' => 'funds#index'

  match '/:controller(/:action(/:id))'
end
