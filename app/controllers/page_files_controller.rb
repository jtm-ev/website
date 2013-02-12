
class PageFilesController < ApplicationController
  def create
    page = Page.find params[:page_id]
    params[:files].each do |file|
      page.page_files.create! file: file
    end
  end
end