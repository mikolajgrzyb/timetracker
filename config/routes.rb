Rails.application.routes.draw do
  root to: 'static_pages#index'

  devise_for :users,
             :controllers => { :registrations => "devise/custom/registrations" }

  devise_scope :user do
    get "signup", to: "devise/registrations#new"
  end

  resource :accounts, only: [:index, :new, :create, :edit, :update, :destroy]
end
