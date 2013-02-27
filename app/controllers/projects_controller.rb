class ProjectsController < ApplicationController
  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Projekte', :projects_path
  
  def filtered_collection
    col = Project.scoped
    unless params[:tags].blank?
      tags = params[:tags].split(':')
      col = col.tagged_with(tags)
      
      first_tag = tags.first
      htags = tags.map {|t| t.humanize}
      add_breadcrumb htags.join(', '), tagged_projects_path(params[:tags])
    end
    col = col.order('id DESC')
  end
  
  # GET /projects
  # GET /projects.json
  def index
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
    @project = Project.find(params[:id])
    
    collection = filtered_collection
    @previous = @project.previous_in(collection)
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
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
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
    @project = Project.find(params[:id])
    
    # Update Image Sorting
    if params[:sorting]
      params[:sorting].each do |sort|
        sort.split(',').each_with_index do |id, index|
          project_file = @project.project_files.find(id.to_i)
          project_file.update_attributes position: index
        end
      end
    end

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
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
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
