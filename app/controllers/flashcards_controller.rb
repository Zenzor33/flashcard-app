class FlashcardsController < ApplicationController

  before_action :set_flashcard, except: :index
  # before_action :set_flashcard_statistic, except: [:index]


  def index  
    @flashcards = Flashcard.search(params)
  end
  

  def show
  end

  private

  def set_flashcard
    @flashcard = Flashcard.find_by(id: params[:id]) || Flashcard.first
    unless @flashcard
      redirect_to contact_path, alert: "Flashcard not found"
    end
  end 

  # def set_flashcard_statistic
  #   @flashcard_statistic = FlashcardStatistic.find_or_initialize_by(user: current_user, flashcard: @flashcard)
  # end 

  # def update_statistic(is_correct) 
  #   flashcard = Flashcard.find(params[:id])
  #   if is_correct 
  #     @flashcard_statistic.correct_count += 1
  #   else 
  #     @flashcard_statistic.incorrect_count += 1
  #   end 
  #   @flashcard_statistic.save 
  # end 
end
