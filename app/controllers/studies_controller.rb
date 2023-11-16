class StudiesController < ApplicationController

  before_action :set_deck_and_deck_flashcards, :set_flashcard_and_flashcard_statistics, :set_next_and_previous_flashcards

  def show
  end

  def next_flashcard
    render :show
  end 

  def previous_flashcard
    render :show
  end 

  def mark_correct
    @flashcard_statistics.correct_count += 1
    @flashcard_statistics.save

    respond_to do |format|
      format.turbo_stream
      format.html 
    end
  end 

  def mark_incorrect
    @flashcard_statistics.incorrect_count += 1
    @flashcard_statistics.save

    respond_to do|format|
      format.turbo_stream
      format.html 
    end
  end 

  def update
  end

  private 
  
  def set_deck_and_deck_flashcards
    @deck = Deck.find_by(user_id: params[:user_id])
    puts "DECK BELOW"
    puts @deck
    @deck_flashcards = @deck.deck_flashcards.order(id: :asc)
    puts "DECK_FLASHCARDS BELOW"
    puts @deck_flashcards
    @deck_flashcard = @deck_flashcards.find_by(id: params[:deck_flashcard]) || @deck_flashcards.find_by(id: params[:format])
    puts "DECK_FLASHCARD BELOW"
    puts @deck_flashcard
    @flashcard = Flashcard.find(@deck_flashcard.flashcard_id) 
    puts "FLASHCARD BELOW"
    puts @flashcard 
  end 

  def set_flashcard_and_flashcard_statistics 
    @flashcard_statistics = FlashcardStatistic.find_by(user_id: current_user, flashcard_id: @flashcard)
  end 

  def set_next_and_previous_flashcards
    next_deck_flashcards = @deck_flashcards.where('id > ?', @deck_flashcard.id)
    if next_deck_flashcards.empty?
      @next_deck_flashcard = nil
    else  
      next_deck_flashcard = next_deck_flashcards.first

      next_flashcard = Flashcard.find_by(id: next_deck_flashcard.flashcard_id) || Flashcard.find_by(id: @deck_flashcards.last.flashcard_id)
      @next_deck_flashcard = next_deck_flashcard
    end 


    previous_flashcards = @deck_flashcards.where('flashcard_id < ?', @deck_flashcard.flashcard_id)
    @previous_flashcard = previous_flashcards.last || @flashcard
  end 
end
