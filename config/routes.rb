Rails.application.routes.draw do
  root to: 'static_pages#index'

  devise_for :users,
             :controllers => { :registrations => "auth/registrations" }

  devise_scope :user do
    get "signup", to: "devise/registrations#new"
  end

  resources :accounts, shallow: true do
    get 'settings', on: :member
    get 'team', on: :member
    get 'timer', on: :member
    resources :invitations
    resources :projects
    resources :timers, only: :index
    resources :teams, only: :index
  end
end
