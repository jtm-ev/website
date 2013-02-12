
class ProjectFilesController < ApplicationController
  
  def create
    project = Project.find params[:project_id]
    params[:files].each do |file|
      project.project_files.create file: file, kind: params[:kind]
    end
  end
  
end