
class TeamsController < ApplicationController
  load_and_authorize_resource
  
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
  
end