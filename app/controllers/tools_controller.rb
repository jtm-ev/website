
class ToolsController < ApplicationController
  skip_authorization_check
  
  layout 'tool'
  
  def image_cropper
    @image = ProjectFile.first
  end
  
end