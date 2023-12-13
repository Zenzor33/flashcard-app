class DeckPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      scope.where(user: user) #dont understand this
    end
  end

  def show? 
    user_owns_record?
  end 

  def add_flashcard?
    # record.user != user 
    user_owns_record? 
  end 

  def remove_flashcard?
    user_owns_record?
  end

  def user_owns_record?
    record.user != user 
  end
end
