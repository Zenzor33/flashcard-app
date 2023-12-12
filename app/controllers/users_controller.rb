class UsersController < ApplicationController
  def index 
    @users = User.all
    authorize @users
  end 

  def show 
    # The show action is used to view the public profiles of users
    @user = User.find(params[:id])
  end 

  def account 
    # The account action displays the current_users account.
    # Only admin and current_user are authorised
    @user = User.find(params[:id])
    authorize @user, :manage_account?
  end
end
