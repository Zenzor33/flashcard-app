class FlashcardsController < ApplicationController

  before_action :set_flashcard, only: [:show, :details, :edit, :update, :destroy, :mark_correct, :mark_incorrect]
  before_action :set_flashcard_statistic


  def show
    @all_ids = Flashcard.order(:id).pluck(:id)
    current_position = @all_ids.index(@flashcard.id)

    @prev_id = @all_ids[current_position - 1] if current_position && current_position > 0
    @next_id = @all_ids[current_position + 1] if current_position && current_position < @all_ids.length - 1
  end

  def details 
  end 

  def mark_correct  
    update_statistic(true)
    # render partial: 'flashcards/flashcard', locals: { flashcard: @flashcard }
    # render @flashcard
    respond_to do |format|
      format.turbo_stream 
      format.html {redirect_to @flashcard}
    end 

  end 
    
  def mark_incorrect 
    update_statistic(false)
    # render partial: 'flashcards/flashcard', locals: { flashcard: @flashcard }
    # render @flashcard
    respond_to do |format|
      format.turbo_stream 
      format.html {redirect_to @flashcard}
    end 

  end  
 

  private

  def set_flashcard
    @flashcard = Flashcard.find_by(id: params[:id]) || Flashcard.first
    unless @flashcard
      redirect_to contact_path, alert: "Flashcard not found"
    end
  end 

  def set_flashcard_statistic
    @flashcard_statistic = FlashcardStatistic.find_or_initialize_by(user: current_user, flashcard: @flashcard)
  end 

  def update_statistic(is_correct) 
    flashcard = Flashcard.find(params[:id])
    if is_correct 
      @flashcard_statistic.correct_count += 1
    else 
      @flashcard_statistic.incorrect_count += 1
    end 
  
    @flashcard_statistic.save 
  end 
end
