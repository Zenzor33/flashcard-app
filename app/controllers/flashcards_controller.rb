class FlashcardsController < ApplicationController
  
  before_action :set_flashcard, except: [:index, :grid, :list]
  # before_action :set_flashcard_statistic, except: [:index]


  def index  
    @flashcards = Flashcard.search(params)
    @deck = current_user.deck
  end
  

  def show
  end

  def grid
    @flashcards = Flashcard.search(params)
    respond_to do |format|
      format.html { render partial: 'flashcards/grid_view', locals: { flashcards: @flashcards } }
      format.js   # if you have grid.js.erb
    end
  end
  
  def list
    @flashcards = Flashcard.search(params)
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

  def add_list
    @deck = current_user.deck 
    @deck.add_flashcard(@flashcard)

    flash.now[:notice] = "Flashcard \"#{@flashcard.front}\" added to Deck"
    
    respond_to do |format|
      format.turbo_stream
      format.html
    end 
  end 

  def remove_list 
    @deck = current_user.deck 
    @deck.remove_flashcard(@flashcard)

    flash.now[:notice] = "Flashcard \"#{@flashcard.front}\" removed from Deck"
    
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end 

  private

  def set_flashcard
    @flashcard = Flashcard.find_by(id: params[:id])
    redirect_to root_path, alert: "Flashcard not found" if @flashcard.nil?
  end 
end
