Rails.application.routes.draw do
  devise_for :users

  resources :flashcards do
    member do
      post :mark_correct
      post :mark_incorrect
    end
  end

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "flashcards#show"

  get 'contact', to: 'contact#show'
end
