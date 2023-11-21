class DecksController < ApplicationController

  # before_action :authenticate_user!
  # before_action :set_flashcard

  def check_deck_flashcards
    if current_user.deck.deck_flashcards.empty?
      redirect_to root_path, alert: "Please add flashcards to your deck to start studying."
    else  
      redirect_to user_deck_study_deck_flashcard_path(current_user, current_user.deck, @first_deck_flashcard_id)
    end 
  end 

  def show 
    @deck = current_user.deck
    @category = params[:category] || 'all'
    @categorized_deck_flashcards = @deck.get_deck_flashcards_by_category(@category)
    @correct_count = @deck.correct_count_sum(current_user, @category)
    @incorrect_count = @deck.incorrect_count_sum(current_user, @category)
    @accuracy = @deck.accuracy(@correct_count, @incorrect_count)

    respond_to do |format|
      format.turbo_stream
      format.html 
    end
  end

  def add_flashcard 
    #Add flashcard to current_user.deck.deck_flashcards
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
