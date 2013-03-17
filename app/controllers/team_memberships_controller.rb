
class TeamMembershipsController < ApplicationController
  load_and_authorize_resource
  
  before_filter :find_team_membership, only: [:edit, :destroy, :update]
  
  def edit
    @team = @team_membership.team
    
    render 'teams/edit'
  end
  
  def destroy
    @team_membership.destroy
    
    redirect_to :back
  end
  
  def update
    @team_membership.update_attributes params[:team_membership]
    
    if params[:files]
      @team_membership.file = params[:files]
      @team_membership.save
    end
    
    respond_to do |format|
      format.html { redirect_to edit_project_team_path(@team_membership.team.project, @team_membership.team) }
      format.json
    end
  end
  
  def create
    TeamMembership.create params[:team_membership]
    redirect_to :back
  end
  
  private
  
    def find_team_membership
      @team_membership = TeamMembership.find(params[:id])
    end
  
end