Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'homes#home'
  get '/home/about' => "homes#about"
  get '/search' => 'users#search'
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
