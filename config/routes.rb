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
    get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
