
class ToolsController < ApplicationController
  # skip_authorization_check
  
  layout 'tool'
  
  def image_cropper
    authorize! :manage, ProjectFile
    # @image = ProjectFile.first
  end
  
end