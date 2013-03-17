
class TeamsController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb 'Projekte', :projects_path
  
  def edit
    add_breadcrumb @team.project.title, edit_project_path(@team.project, anchor: 'teams')
    add_breadcrumb @team.name
    
    @team_membership = TeamMembership.new
    @prev = @team.prev_in(@team.project.teams)
    @next = @team.next_in(@team.project.teams)
  end
  
  def update
    if params[:files]
      @team.file = params[:files]
      @team.save
    end
  end
  
  def destroy
    project = @team.project
    
    @team.destroy
    
    redirect_to edit_project_path(project, anchor: 'teams')
  end
  
end