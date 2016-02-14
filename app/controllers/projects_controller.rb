class ProjectsController < ApplicationController
  load_and_authorize_resource except: [:index]

  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Projekte', :projects_path

  # GET /projects
  # GET /projects.json
  def index
    authorize! :read, Project

    @projects = Project.search(params[:page], params[:search])
    @all_projects = Project.all

    respond_to do |format|
      format.html #index.html.erb
      format.js #index.js.erb
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

  # GET /projects/new
  # GET /projects/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @next = @project.next_in(Project.latest_first)
    @prev = @project.prev_in(Project.latest_first)
  end

  # POST /projects
  # POST /projects.json
  def create

    respond_to do |format|
      if @project.save
        format.html { redirect_to edit_project_path(@project) }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update

    # Update Image Sorting
    if params[:sorting]
      params[:sorting].each do |sort|
        sort.split(',').each_with_index do |id, index|
          project_file = @project.project_files.find(id.to_i)
          project_file.update_attributes position: index
        end
      end
    end

    if params[:file_descriptions]
      params[:file_descriptions].each do |id, value|
        ProjectFile.find(id).update_attributes description: value
      end
    end

    if params[:events]
      params[:events].each do |id, params|
        @project.events.find(id).update_attributes params
      end
    end

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to action: :edit, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
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
