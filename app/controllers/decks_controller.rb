class DecksController < ApplicationController

  before_action :set_deck, except: :check_deck_flashcards
  before_action :set_flashcard, only: [:add_flashcard, :remove_flashcard]

  def check_deck_flashcards
    if current_user.deck.deck_flashcards.empty?
      redirect_to root_path, alert: "Please add flashcards to your deck to start studying."
    else  
      redirect_to user_deck_study_deck_flashcard_path(current_user, current_user.deck, @first_deck_flashcard_id)
    end 
  end 

  def show 
    @category = params[:category] || 'all'
    @categorized_deck_flashcards = @deck.get_deck_flashcards_by_category(@category)

    respond_to do |format|
      format.turbo_stream
      format.html 
    end
  end

  def add_flashcard 
    @deck.add_flashcard(@flashcard)

    respond_to do |format|
      format.turbo_stream {render :create}
      format.html
    end
  end 

  def remove_flashcard 
    @deck.remove_flashcard(@flashcard)
    
    respond_to do |format|
      format.turbo_stream {render :create}
      format.html
    end
  end

  private 

  def set_deck 
    @deck = current_user.deck
  end 

  def set_flashcard 
    @flashcard = Flashcard.find(params[:flashcard_id].to_i)
  end

end
