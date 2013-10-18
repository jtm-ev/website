
class MembersController < ApplicationController
  load_and_authorize_resource
  
  # GET /members/1
  # GET /members/1.json
  def show
    # if params[:project_id]  # Actors of Project
    #   @project = Project.find(params[:project_id])
    #   collection = @project.actor_teams.members
    #   
    #   # @act = collection.find()
    #   
    #   
    #   add_breadcrumb 'Projekte', :projects_path
    #   add_breadcrumb @project.title, "#{project_path(@project)}#darsteller"
    #   
    #   
    #   
    #   @previous = @member.previous_in(collection)
    #   @next = @member.next_in(collection)
    # end
    
    add_breadcrumb @member.full_name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end
end