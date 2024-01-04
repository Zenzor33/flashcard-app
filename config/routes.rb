# == Route Map
#

Rails.application.routes.draw do
  devise_for :users

  resources :users
  get 'users/:id/account', to: 'users#account'
  resources :flashcards do 
    member do 
      post 'add'
      post 'add_list'
      delete 'remove'
      get 'remove_list'
    end 
    collection do 
      get 'grid'
      get 'list'
      post "bulk"
    end 
  end 

  resources :user do 
    resources :decks do 
      member do 
        post 'add_flashcard'
        delete 'remove_flashcard'
      end 

      collection do 
        get 'check_deck_flashcards'
      end 
      resources :deck_flashcards, only: [:show, :update] do 
        member do
          post :mark_correct
          post :mark_incorrect
        end
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "flashcards#index"

  get 'contact', to: 'contact#show'
end
