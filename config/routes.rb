# frozen_string_literal: true

Rails.application.routes.draw do
  resources :spams, only: [] do
    collection do
      get :check
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
