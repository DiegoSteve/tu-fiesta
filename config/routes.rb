  Rails.application.routes.draw do
    devise_for :users, controllers: {
      sessions: 'users/sessions',
      confirmations: 'users/confirmations',
      passwords: 'users/passwords',
      unlocks: 'users/unlocks',
      omniauth: 'users/omniauth',
      registrations: 'users/registrations'
    }

    resources :guests
    resources :events

    resources :events do
      resources :guests
    end

    resources :invitations, only: [:new, :create]

    get 'home/index'
    get 'homepage', to: 'events#homepage'

    # config/routes.rb
    get '/not_available', to: 'invitations#not_available', as: :not_available

    resources :events do
      resources :invitations, only: [:create]
    end

    resources :events do
      post 'send_invitations', to: 'invitations#send_invitations'
    end

    # config/routes.rb
    resources :events do
      member do
        get 'event_report', to: 'reports#event_report', format: :pdf
      end
    end

    resources :invitations do
      member do
        get :confirm
      end
    end

    resources :events do
      member do
        post 'confirm_attendance'
      end
    end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
