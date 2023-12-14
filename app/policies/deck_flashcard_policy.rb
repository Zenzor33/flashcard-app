class DeckFlashcardPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # scope.joins(:deck).where(decks: { user_id: user.id })
    end
  end

  def show?
    user_owns_record?
  end 

  def next_flashcard?
    user_owns_record?
  end 

  def previous_flashcard?
    user_owns_record?
  end 

  def mark_correct?
    user_owns_record?
  end 

  def mark_incorrect?
    user_owns_record?
  end 

  private 

  def user_owns_record?
    record.deck.user == @user
  end 
end
