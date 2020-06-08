Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'homes#home'
  get '/home/about', to: "homes#about"
  get '/search', to: 'users#search'
  get '/sort', to: 'books#index', as: :sort
  get 'chat/:id', to: 'chats#show', as: :chat
  get 'tags/:tag', to: 'books#index', as: :tag
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
  resources :chats, only: [:create]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
