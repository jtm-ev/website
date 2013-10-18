
class TeamMembershipsController < ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :js
  
  before_filter :find_team_membership, only: [:edit, :destroy, :update]
  
  def edit
    @team = @team_membership.team
    
    render 'teams/edit'
  end
  
  def destroy
    @team_membership.destroy
    
    respond_with()
  end
  
  def update
    if params[:files]
      @team_membership.file = params[:files]
    end
    
    @team_membership.update_attributes params[:team_membership]
    
    respond_to do |format|
      format.html { redirect_to edit_project_team_path(@team_membership.team.project, @team_membership.team) }
      format.json
    end
  end
  
  def create
    @team_membership = TeamMembership.create(params[:team_membership])
    respond_with()
  end
  
  private
  
    def find_team_membership
      @team_membership = TeamMembership.find(params[:id])
    end
  
end