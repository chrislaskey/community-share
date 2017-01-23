Rails.application.routes.draw do
  resources :documents
  resources :document_tags, path: "document-tags", only: [:show]
  resources :tags
end
