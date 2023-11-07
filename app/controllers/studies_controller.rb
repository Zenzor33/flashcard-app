class StudiesController < ApplicationController
  def show
    @prev_id = 1
    @next_id = 2
    @flashcard = Flashcard.find(1)
    @deck = Deck.where(user_id: current_user)
  end

  def update
  end
end
