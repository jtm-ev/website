class ProjectsController < ApplicationController
  load_and_authorize_resource except: [:index]
  
  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Projekte', :projects_path
  
  # GET /projects
  # GET /projects.json
  def index
    authorize! :read, Project
    
    @projects = filtered_collection
    # @projects = @projects.order(id: :desc)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    collection = filtered_collection
    @previous = @project.prev_in(collection)
    @next     = @project.next_in(collection)

    add_breadcrumb @project.title

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end


  
  private
    def filtered_collection
      col = Project.latest_first
      
      unless params[:tags].blank?
        tags = params[:tags].split(':')
        col = col.tagged_with(tags)

        first_tag = tags.first
        htags = tags.map {|t| t.humanize}
        add_breadcrumb htags.join(', '), tagged_projects_path(params[:tags])
      end

      col
    end
end
