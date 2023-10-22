class FlashcardsController < ApplicationController

  before_action :set_flashcard, only: [:show]

  def show
    @all_ids = Flashcard.order(:id).pluck(:id)
    current_position = @all_ids.index(@flashcard.id)

    @prev_id = @all_ids[current_position - 1] if current_position && current_position > 0
    @next_id = @all_ids[current_position + 1] if current_position && current_position < @all_ids.length - 1
  end

  private

  def set_flashcard
    @flashcard = Flashcard.find_by(id: params[:id]) || Flashcard.first
  end 
end
