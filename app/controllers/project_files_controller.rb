
class ProjectFilesController < ApplicationController
  
  def create
    Rails.logger.info "Upload File: #{params.inspect}"
    project = Project.find params[:project_id]
    params[:files].each do |file|
      project.project_files.create file: file, kind: params[:kind]
      # project.press.create file: file
    end
  end
  
end