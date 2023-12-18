class FlashcardsController < ApplicationController
  
  before_action :set_flashcard, except: [:index, :grid, :list]
  # before_action :set_flashcard_statistic, except: [:index]


  def index  
    @flashcards = Flashcard.search(params)
  end
  

  def show
  end

  def grid
    @flashcards = Flashcard.all
    respond_to do |format|
      format.html { render partial: 'flashcards/grid_view', locals: { flashcards: @flashcards } }
      format.js   # if you have grid.js.erb
    end
  end
  
  def list
    @flashcards = Flashcard.all
    respond_to do |format|
      format.html { render partial: 'flashcards/list_view', locals: { flashcards: @flashcards } }
      format.js   # if you have list.js.erb
    end
  end

  private

  def set_flashcard
    @flashcard = Flashcard.find_by(id: params[:id])
    redirect_to root_path, alert: "Flashcard not found" if @flashcard.nil?
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
