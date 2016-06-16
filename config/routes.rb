Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :posts
  end

  devise_scope :user do
    authenticated :user do
      #root 'users#index', as: :authenticated_root
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :conversations do
    resources :messages
  end

end
