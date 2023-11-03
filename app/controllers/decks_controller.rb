class DecksController < ApplicationController

  # before_action :authenticate_user!

  def add_flashcard 
    @deck = current_user.deck
    @deck.add_flashcard_to_deck(params[:id])
    redirect_back(fallback_location: flashcards_path)
  end 
end
