Rails.application.routes.draw do
  root to: 'static_pages#index'

  devise_for :users,
             :controllers => { :registrations => "devise/custom/registrations" }

  devise_scope :user do
    get "signup", to: "devise/registrations#new"
  end

  resources :accounts, shallow: true do
    resources :projects
    resources :timers, only: :index
    resources :teams, only: :index
  end
end
