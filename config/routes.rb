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
    collection do
      resources :document_search, path: "search", only: [:index]
    end
    member do
      get :download
    end
  end

  resources :document_tags, path: "document-tags", only: [:show]
  resources :downloads

  resources :memberships do
    collection do
      resources :memberships_bulk, path: "bulk", only: [:new, :create]
    end
  end

  resources :tags

  get :login, to: "login#index"

  match :register, to: "home#register", via: [:get, :post], as: "community-registrations"

  root to: "home#index"
end
