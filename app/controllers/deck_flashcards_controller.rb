class DeckFlashcardsController < ApplicationController
  before_action :set_deck, :set_deck_flashcards, :set_deck_flashcard, :set_next_deck_flashcard, :set_previous_deck_flashcard 

  def show
    # binding.pry
  end

  def next_flashcard
    render :show
  end 

  def previous_flashcard
    render :show
  end 

  def mark_correct
    @deck_flashcard.correct_count += 1
    @deck_flashcard.save
    @deck.update_statistics

    respond_to do |format|
      format.turbo_stream
      format.html 
    end
  end 

  def mark_incorrect
    @deck_flashcard.incorrect_count += 1
    @deck_flashcard.save
    @deck.update_statistics

    respond_to do |format|
      format.turbo_stream
      format.html 
    end
  end 

  def update
  end

  private 
  
  def set_deck
    @deck = Deck.find_by(user_id: params[:user_id])
  end 

  def set_deck_flashcards 
    @deck_flashcards = @deck.deck_flashcards.order(id: :asc)
  end 

  def set_deck_flashcard 
    # Displays statistics and information in the study page (deck_flashcards#show) & decks stats_body (decks#show)
    @deck_flashcard = @deck_flashcards.find_by(id: params[:id]) || @deck_flashcards.find_by(id: params[:format])
  end 

  def set_next_deck_flashcard
    # Sets the link_to "next" in the study page (deck_flashcards#show)
    next_deck_flashcards = @deck_flashcards.where('id > ?', @deck_flashcard.id)
    next_deck_flashcards.empty? ? @next_deck_flashcard = nil : @next_deck_flashcard = next_deck_flashcards.first
  end 

  def set_previous_deck_flashcard
    # Sets the link_to "previous" in the study page
    previous_deck_flashcards = @deck_flashcards.where('id < ?', @deck_flashcard.id)
    previous_deck_flashcards.empty? ? @previous_deck_flashcard = nil : @previous_deck_flashcard = previous_deck_flashcards.last
  end 

end
