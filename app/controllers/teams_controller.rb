
class TeamsController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb 'Projekte', :projects_path
  
  def new
    @project = Project.find(params[:project_id])
    @team = @project.teams.new
  end
  
  def create
    @project = Project.find(params[:project_id])
    @team = @project.teams.create(params[:team])
    redirect_to edit_project_team_path(@project, @team)
  end
  
  def edit
    add_breadcrumb @team.project.title, edit_project_path(@team.project, anchor: 'teams')
    add_breadcrumb @team.name
    
    @team_membership = TeamMembership.new
    @prev = @team.prev_in(@team.project.teams)
    @next = @team.next_in(@team.project.teams)
  end
  
  def update
    if params[:move]
      target = Team.find(params[:team][:id].to_i)
      TeamMembership.where(id: params[:selection]).each do |i|
        i.team = target
        i.save
      end
    else
    
      if params[:files]
        @team.file = params[:files]
        @team.save
      end
    
      if params[:team_memberships]
        # Mass-Update GroupMemberships
        @team.team_memberships.update params[:team_memberships].keys, params[:team_memberships].values
      end
    
      @team.update_attributes params[:team]
      
    end
    
    redirect_to action: :edit
    
  end
  
  def destroy
    project = @team.project
    
    @team.destroy
    
    redirect_to edit_project_path(project, anchor: 'teams')
  end
  
end