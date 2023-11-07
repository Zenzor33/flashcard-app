class StudiesController < ApplicationController
  def show
    @deck = Deck.find_by(user_id: params[:user_id])
    # flashcard_ids = @deck.flashcards.pluck(:id)
    @flashcard = @deck.flashcards.first
    
    next_flashcard_id = @flashcard.id + 1 #This is BAD
    # @next_flashcard = @deck.flashcards.find(next_flashcard_id)
    @next_flashcard = Flashcard.find(3)

    prev_flashcard_id = @flashcard.id - 1 unless @flashcard.id = 1 #I KNOW ITS AWFUL
    @previous_flashcard = prev_flashcard_id ? @deck.flashcards.find(prev_flashcard_id) : nil
  end

  def update
  end
end
