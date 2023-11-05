# == Route Map
#

Rails.application.routes.draw do
  # resources :decks

  devise_for :users

  resources :user do 
    resources :decks do 
      member do 
        post 'add_flashcard'
        delete 'remove_flashcard'
        get 'category/:category', action: :show_category, as: 'category'
      end 
    end
  end

  resources :flashcards do
    member do
      post :mark_correct
      post :mark_incorrect
      get 'details'
    end
  end

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "flashcards#index"

  get 'contact', to: 'contact#show'
end
