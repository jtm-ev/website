
class PageFilesController < ApplicationController
  load_and_authorize_resource except: [:create]
  
  def create
    @page = Page.find params[:page_id]
    authorize! :update, @page
    
    uploaded_files.each do |file|
      @page.page_files.create! file: file
    end
  end
  
  def destroy
    @page_file.destroy
    
    redirect_to :back
  end
  
  private
    def uploaded_files
      if params[:files]
        return params[:files].is_a?(Array) ? params[:files] : [params[:files]]
      end
      []
    end
end