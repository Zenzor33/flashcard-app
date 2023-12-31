class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index? 
    @user.admin?
  end 

  def manage_account?
    user == record || user.admin?
  end
end
