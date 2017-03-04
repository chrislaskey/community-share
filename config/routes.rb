Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    match "sign_out", to: "devise/sessions#destroy", via: [:delete, :get], as: :user_log_out
  end

  resources :communities, only: [:index, :edit, :update] do
    member do
      get :login
    end
  end

  resources :documents do
    member do
      get :download
    end
  end

  resources :document_tags, path: "document-tags", only: [:show]
  resources :downloads
  resources :memberships
  resources :tags

  get :login, to: "login#index"

  match :register, to: "home#register", via: [:get, :post], as: "community-registrations"

  root to: "home#index"
end
