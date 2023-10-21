class FlashcardsController < ApplicationController

  before_action :set_flashcard, only: [:show]

  def show
    @prev_id = @flashcard.id - 1 unless @flashcard.id == 1
    @next_id = @flashcard.id + 1 unless @flashcard.id == Flashcard.last.id
  end

  private

  def set_flashcard
    @flashcard = Flashcard.find_by(id: params[:id]) || Flashcard.first
  end 
end
