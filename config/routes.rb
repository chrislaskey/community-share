Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    delete "sign_out", to: "devise/sessions#destroy", as: :user_log_out
  end

  get :login, to: "login#index"

  resources :documents do
    member do
      get :download
    end
  end

  resources :document_tags, path: "document-tags", only: [:show]
  resources :downloads
  resources :memberships
  resources :tags

  root to: "home#index"
end
