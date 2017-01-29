Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :user_log_out
  end

  resources :documents
  resources :document_tags, path: "document-tags", only: [:show]
  resources :tags

  root to: redirect("/documents")
end
