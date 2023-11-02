class DecksController < ApplicationController

  before_action :authenticate_user!

  def index 
    # Redirect to show with choice of category by default
    # Show path: /user/:user_id/decks/:id(.:format)
    # The last :id will represent the category (All, New, Learning, Progressing, Mastered)
    # The default is all.
    # If user's deck is empty, render an empty page

    # if deck.exist
      # redirect_to action:show id - getIdfFromMethodIn Deck.rb
    # else
      #render :empty
    #end
    
  end 

  def show 
  end 
end
