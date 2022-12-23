Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :cats , expect: :destroy do
  resources :cat_rental_requests , only: [:new ,:create]
    
  end

  resources :pages do
    collection do
      get :approve_request
      get :deny_request
    end
  end

  resources :users , only:[:new,:create]

  resource :session , only:[:create , :new , :destroy] 

  root to: redirect('/cats')
end
