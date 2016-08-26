Rails.application.routes.draw do
  devise_for :users
  get 'get_user' => 'users#get_user'
  get 'render_post' => 'posts#render_post'
  get 'active_chatrooms' => 'chatrooms#active_chatrooms'
  resources :users do
    resources :posts do
      resources :comments, :only => [:show, :create, :destroy, :edit, :update, :new] do
        member do
          post 'like'
        end
      end
      member do
        get 'show_comments'
        post 'like'
      end
    end
    resources :friendships, only: [:index, :destroy, :update, :create]
  end

  resources :chatrooms do
    resources :messages
    member do
      get 'del_from_sessions'
      get 'open_chat'
    end
  end

  devise_scope :user do
    authenticated :user do
      #root 'users#index', as: :authenticated_root
      root 'home#index', as: :authenticated_root
      get 'home/autocomplete_user_username'
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

end
