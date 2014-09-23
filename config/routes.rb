Rails.application.routes.draw do
  root to: 'static_pages#index'

  devise_for :users,
             :controllers => { :registrations => "devise/custom/registrations" }

  devise_scope :user do
    get "signup", to: "devise/registrations#new"
  end

  resource :accounts, only: [:show] do
    post
  end

  post 'invite', to: 'accounts#invite'
end
