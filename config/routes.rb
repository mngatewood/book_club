Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :authors, only: [:show, :destroy]
  # resources :books, only: [:index, :new, :create, :show, :destroy] do
  #   resources :reviews, only: [:new, :create]
  # end 
  # resources :reviews, only: [:new, :create, :destroy]
  # resources :users, only: [:show]
  
  get 'authors/:id', to: 'authors#show', as: 'author'
  delete 'authors/:id', to: 'authors#destroy'

  get 'books', to: 'books#index'
  post 'books', to: 'books#create'
  get 'books/new', to: 'books#new', as: 'new_book'
  get 'books/:id', to: 'books#show', as: 'book'
  delete 'books/:id', to: 'books#destroy'

  post 'books/:book_id/reviews', to: 'reviews#create', as: 'book_reviews'
  get 'books/:book_id/reviews/new', to: 'reviews#new', as: 'new_book_reviews'

  post 'reviews', to: 'reviews#create'
  get 'reviews/new', to: 'reviews#new', as: 'new_review'
  delete 'reviews/:id', to: 'reviews#destroy', as: 'review'

  get 'users/:id', to: 'users#show', as: 'user'

end
