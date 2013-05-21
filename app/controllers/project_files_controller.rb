
class ProjectFilesController < ApplicationController
  load_and_authorize_resource #except: [:create]
  
  def create
    project = Project.find params[:project_id]
    authorize! :update, project
    
    uploaded_files.each do |file|
      project.project_files.create file: file, kind: params[:kind]
    end
  end
  
  def destroy
    @project_file.destroy
    
    redirect_to edit_project_path(@project_file.project, anchor: 'bilder')
  end
  
  private
    def uploaded_files
      if params[:files]
        return params[:files].is_a?(Array) ? params[:files] : [params[:files]]
      end
      []
    end
  
end