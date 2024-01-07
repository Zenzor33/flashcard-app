class FlashcardsController < ApplicationController
  
  before_action :set_flashcard, except: [:index, :grid, :list, :bulk]
  # before_action :set_flashcard_statistic, except: [:index]


  def index  
    @pagy, @flashcards = pagy(Flashcard.search(params))
    @deck = current_user.deck
  end
  

  def show
  end

  def edit 
    
  end

  def update 
    if @flashcard.update(flashcard_params) 
      flash[:success] = "Flashcard sucessfully updated"
      redirect_to @flashcard 
    else  
      flash[:error] = "Something went wrong"
      redirect_to edit_flashcard_path 
    end
  end

  def grid
    @flashcards = Flashcard.search(params)
    respond_to do |format|
      format.html { render partial: 'flashcards/grid_view', locals: { flashcards: @flashcards } }
      format.js   # if you have grid.js.erb
    end
  end
  
  #WHat is this used for?
  def list
    @pagy, @flashcards = pagy(Flashcard.search(params))
    respond_to do |format|
      format.html { render partial: 'flashcards/list_view', locals: { flashcards: @flashcards } }
      format.js   # if you have list.js.erb
    end
  end

  def add 
    @deck = current_user.deck 
    @deck.add_flashcard(@flashcard)

    flash.now[:notice] = "Flashcard \"#{@flashcard.front}\" added to Deck"
    
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end 

  def remove 
    @deck = current_user.deck 
    @deck.remove_flashcard(@flashcard)

    flash.now[:notice] = "Flashcard \"#{@flashcard.front}\" removed from Deck"
    
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end 

  # def add_list
  #   @deck = current_user.deck 
  #   @deck.add_flashcard(@flashcard)

  #   flash.now[:notice] = "Flashcard \"#{@flashcard.front}\" added to Deck"
    
  #   respond_to do |format|
  #     format.turbo_stream
  #     format.html
  #   end 
  # end 

  # def remove_list 
  #   @deck = current_user.deck 
  #   @deck.remove_flashcard(@flashcard)

  #   flash.now[:notice] = "Flashcard \"#{@flashcard.front}\" removed from Deck"
    
  #   respond_to do |format|
  #     format.turbo_stream
  #     format.html
  #   end
  # end 

  def bulk 
    operation = params[:operation]
    selected_flashcard_ids = params[:selected_flashcards]
    unless selected_flashcard_ids.nil?
      @deck = current_user.deck 
      @deck.update_flashcards(selected_flashcard_ids, operation)
    end

    @flashcards = Flashcard.all

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy 
    if @flashcard.destroy 
      flash[:success] = "Flashcard was successfully deleted"
      redirect_to flashcards_path
    else  
      flash[:error] = "There was a problem deleting the flashcard"
      redirect_to @flashcard 
    end
  end 

  private

  def set_flashcard
    @flashcard = Flashcard.find_by(id: params[:id])
    redirect_to root_path, alert: "Flashcard not found" if @flashcard.nil?
  end 

  def flashcard_params
    params.require(:flashcard).permit(:front, :back)
  end
end
