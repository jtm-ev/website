
class PageFilesController < ApplicationController
  def create
    page = Page.find params[:page_id]
    uploaded_files.each do |file|
      page.page_files.create! file: file
    end
  end
  
  def destroy
    pf = PageFile.find params[:id]
    pf.destroy
    
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