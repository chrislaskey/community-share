Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :documents
  resources :document_tags, path: "document-tags", only: [:show]
  resources :tags

  root to: redirect("/documents")
end
