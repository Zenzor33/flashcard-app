class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_back(fallback_location: root_path)
  # end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
 
    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_back(fallback_location: root_path)
  end
end
