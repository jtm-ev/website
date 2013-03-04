
class UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
    # @users = User.all
  end
  
  def edit
    
  end
  
  def update
    @user.update_attributes params[:user]
    redirect_to action: :index
  end
end