class FlashcardsController < ApplicationController

  before_action :set_flashcard, only: [:show, :edit, :update, :destroy, :mark_correct, :mark_incorrect]

  def show
    @all_ids = Flashcard.order(:id).pluck(:id)
    current_position = @all_ids.index(@flashcard.id)

    @prev_id = @all_ids[current_position - 1] if current_position && current_position > 0
    @next_id = @all_ids[current_position + 1] if current_position && current_position < @all_ids.length - 1
  end

  def mark_correct  
    update_statistic(true)
    render partial: 'flashcards/flashcard', locals: { flashcard: @flashcard }
    # render @flashcard

  end 
    
  def mark_incorrect 
    update_statistic(false)
    render partial: 'flashcards/flashcard', locals: { flashcard: @flashcard }
    # render @flashcard

  end  
 

  private

  def set_flashcard
    @flashcard = Flashcard.find_by(id: params[:id]) || Flashcard.first
  end 

  def update_statistic(is_correct) 
    flashcard = Flashcard.find(params[:id])
    statistic = FlashcardStatistic.find_or_initialize_by(user: current_user, flashcard: flashcard)
  
    if is_correct 
      statistic.correct_count += 1
    else 
      statistic.incorrect_count += 1
    end 
  
    statistic.save 
  end 
end
