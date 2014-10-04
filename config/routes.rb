Rails.application.routes.draw do
  root to: 'static_pages#index'

  devise_for :users, controllers: { :registrations => "devise/custom/registrations" }

  # devise_scope :user do
  #   get "signup", to: "devise/registrations#new"
  #   get "login", to: "devise/sessions#new"
  #   get "logout", to: "devise/sessions#destroy"
  # end

  resources :accounts do
    get 'settings', on: :member
    get 'team', on: :member
    get 'timer', on: :member
    resources :invitations
    resources :projects
    resources :timers, only: :index
    resources :teams, only: :index
  end
end
