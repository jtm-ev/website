class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  
  rescue_from CanCan::AccessDenied, :with => :unauthorized
  
  helper_method :sort_column, :sort_direction
  
  protect_from_forgery
  check_authorization :unless => :devise_controller?
  
  def unauthorized
    if current_user
      render 'unauthorized'
    else
      redirect_to :root
    end
  end
  
  private
    def after_sign_in_path_for(user)
      stored_location_for(user) || "/dashboard"
    end

    def default_sort_column
      "created_at"
    end

    def sort_column
      # User.column_names.include?(params[:sort]) ? 
      params[:sort] or default_sort_column
    end

    def sort_direction
      (%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc").to_sym
    end
  
end
