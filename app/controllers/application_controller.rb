class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_first_deck_flashcard_id

  private 

  def set_first_deck_flashcard_id
    if current_user
      @first_deck_flashcard_id = current_user.deck.deck_flashcards.order(id: :asc).first.id
    end
  end 
end
