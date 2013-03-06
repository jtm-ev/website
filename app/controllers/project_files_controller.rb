
class ProjectFilesController < ApplicationController
  # load_and_authorize_resource except: [:create]
  
  def create
    project = Project.find params[:project_id]
    authorize! :manage, project
    
    params[:files].each do |file|
      project.project_files.create file: file, kind: params[:kind]
    end
  end
  

  
end