class DecksController < ApplicationController

  # before_action :authenticate_user!
  # before_action :set_flashcard

  def show 
    @deck = current_user.deck
    @category = params[:category] || 'all'
    @categorized_flashcards = @deck.get_flashcards_by_category(current_user, @category)
    @flashcard_statistics = @deck.flashcard_statistics_for_user(current_user)
    @correct_count = @deck.correct_count_sum(current_user)
    @incorrect_count = @deck.incorrect_count_sum(current_user)
    @accuracy = @deck.accuracy(@correct_count, @incorrect_count)
  end

  def add_flashcard 
    @deck = current_user.deck
    flashcard = Flashcard.find(params[:flashcard_id].to_i)
    @deck.add_flashcard_to_deck(flashcard)

    @flashcard = Flashcard.find(params[:flashcard_id])

    respond_to do |format|
      format.turbo_stream {render :create}
      format.html
    end
  end 

  def remove_flashcard
    @deck = current_user.deck 
    flashcard = Flashcard.find(params[:flashcard_id].to_i)
    @deck.remove_flashcard_from_deck(flashcard)
    
    @flashcard = Flashcard.find(params[:flashcard_id])

    respond_to do |format|
      format.turbo_stream {render :create}
      format.html
    end
  end
end
