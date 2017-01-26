Rails.application.routes.draw do
  get "/auth/:provider/callback" => "sessions#create"

  resources :documents
  resources :document_tags, path: "document-tags", only: [:show]
  resources :tags

  root to: redirect("/documents")
end
