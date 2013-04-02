
class UsersController < ApplicationController
  load_and_authorize_resource except: [:profile, :dashboard]
  skip_authorization_check only: [:profile, :dashboard]
  
  before_filter :authenticate_user!
  
  add_breadcrumb 'Intern', :dashboard_path
  
  def index
    # @users = User.all
  end
  
  def edit
    @roles = [
      Role.find_or_create_by_name('member_manager'),
      Role.find_or_create_by_name('site_manager'),
      Role.find_or_create_by_name('project_manager')
    ]
    @roles.push Role.find_or_create_by_name('admin') if current_user.has_role?(:admin)
  end
  
  def update
    params[:user][:role_ids] ||= []
    @user.update_attributes params[:user]
    @user.create_activity :update, owner: current_user
    redirect_to action: :index
  end
  
  ######################################################
  
  def profile
    add_breadcrumb 'Profil'
    @user = current_user
  end
  
  def dashboard
    add_breadcrumb 'Dashboard'
    @activities = PublicActivity::Activity.order('created_at desc').limit(50)
  end
end