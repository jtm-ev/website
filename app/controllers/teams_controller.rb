
class TeamsController < ApplicationController
  before_filter :find_team, only: [:edit, :update, :destroy]
  
  def edit
    @team_membership = TeamMembership.new
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
    
    redirect_to project
  end
  
  private
    def find_team
      @team = Team.find(params[:id])
    end
  
end