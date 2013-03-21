
class UsersController < ApplicationController
  load_and_authorize_resource except: [:profile, :dashboard]
  skip_authorization_check only: [:profile, :dashboard]
  
  before_filter :authenticate_user!
  
  add_breadcrumb 'Intern', :dashboard_path
  
  def index
    # @users = User.all
  end
  
  def edit
    
  end
  
  def update
    @user.update_attributes params[:user]
    redirect_to action: :index
  end
  
  ######################################################
  
  def profile
    add_breadcrumb 'Profil'
    @user = current_user
  end
  
  def dashboard
    add_breadcrumb 'Dashboard'
    
  end
end