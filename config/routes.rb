Rails.application.routes.draw do

  root "static_pages#home", page: "home"
  
  get "/static_pages/page", to: "static_pages#home"

  get "/signup", to: "users#new"
  post "/signup",  to: "users#create"
  
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  get "/edit", to: "users#edit"
  post "/update", to: "users#update"

  delete "/logout", to: "sessions#destroy"
  
  resources :users, except: [:new, :destroy]
  resources :users do
    get "/:relationship", on: :member,
      to: "relationships#index", as: :relationships
    resources :favorites, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :requests, exept: [:new]
  
  resources :books, only: [:index, :show] do
    resources :reviews, except: :index do
      resources :comments, only: [:create, :update, :destroy]
    end
    resources :reading_statuses, only: [:create, :update]
  end

  namespace :admin do
    resources :categories do
      resources :books, only: [:create]
    end
    resources :books
    resources :requests, only: [:index, :destroy]
  end
end
