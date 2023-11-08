class StudiesController < ApplicationController

  before_action :set_deck_and_flashcards
  before_action :set_flashcard
  before_action :set_next_and_previous_flashcards

  def show
  end

  def next_flashcard
    render :show
  end 

  def previous_flashcard
    render :show
  end 

  def update
  end

  private 
  
  def set_deck_and_flashcards
    @deck = Deck.find_by(user_id: params[:user_id])
    @flashcards = @deck.flashcards
  end 

  def set_flashcard 
    @flashcard = @flashcards.find(params[:id]) || @flashcards.first
  end 

  def set_next_and_previous_flashcards
    next_flashcards = @flashcards.where('flashcards.id > ?', @flashcard)
    @next_flashcard = next_flashcards.first || @flashcard

    previous_flashcards = @flashcards.where('flashcards.id < ?', @flashcard)
    @previous_flashcard = previous_flashcards.last || @flashcard
  end 
end
