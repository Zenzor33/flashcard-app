class DecksController < ApplicationController

  # before_action :authenticate_user!
  # before_action :set_flashcard

  def show 
    @deck = current_user.deck
    @category = params[:category] || 'all'
    @categorized_flashcards = @deck.get_flashcards_by_category(@category)
  end

  def add_flashcard 
    @deck = current_user.deck
    @deck.add_flashcard_to_deck(params[:flashcard_id])

    @flashcard = Flashcard.find(params[:flashcard_id])

    respond_to do |format|
      format.turbo_stream {render :create}
      format.html
    end
  end 

  def remove_flashcard
    @deck = current_user.deck 
    @deck.remove_flashcard_from_deck(params[:flashcard_id].to_i)
    
    @flashcard = Flashcard.find(params[:flashcard_id])

    respond_to do |format|
      format.turbo_stream {render :create}
      format.html
    end
  end
end
