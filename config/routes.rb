Rails.application.routes.draw do
  get 'documents/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :documents, only: [:create]
end
