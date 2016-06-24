Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :posts do
      resources :comments, :only => [:show, :create, :delete, :destroy, :edit, :update] do
        member do
          post 'like'
        end
      end
      member do
        get 'show_comments'
        post 'like'
      end
    end
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

end
