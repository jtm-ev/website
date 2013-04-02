
class ProjectFilesController < ApplicationController
  load_and_authorize_resource except: [:crop]
  
  skip_before_filter :verify_authenticity_token, only: :crop
  skip_authorization_check only: :crop
  
  
  def index
    @images = Project.find(125).images #ProjectFile.all
    @image = @images.last
    render layout: 'tool'
  end
  
  def crop
    @project_file = ProjectFile.find(params[:id])
    Rails.logger.info "\n CROP: #{params} \n"
    @project_file.meta[:crop] = params[:crop]
    @project_file.save
    
    @project_file.file.reprocess!
    
    render json: {}, status: :ok
  end
  
  def create
    project = Project.find params[:project_id]
    authorize! :manage, project
    
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