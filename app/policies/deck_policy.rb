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
    record.user == user
  end 

  def add_flashcard?
    record.user == user 
  end 

  def remove_flashcard?
    record.user == user
  end
end
