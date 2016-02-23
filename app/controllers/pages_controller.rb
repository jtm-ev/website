class PagesController < ApplicationController
  add_breadcrumb "Home", :root_path
  load_and_authorize_resource except: [:index, :show_by_path]

  # GET /pages
  # GET /pages.json
  def index
    authorize! :manage, Page

    @pages = Page.where(nil).order('show_in_navigation DESC, title').roots    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show

    add_breadcrumbs_for(@page)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  def show_by_path
    Rails.logger.info params.inspect
    @page = Page.find_by_path(params[:path])
    authorize! :read, @page

    add_breadcrumbs_for(@page)

    render action: :show
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.create(title: "Neue Seite #{Page.count}")
    respond_to do |format|
      format.html { redirect_to edit_page_path(@page) }
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update

    if params[:sorting]
      params[:sorting].split(',').each_with_index do |id, index|
        p = Page.find(id.to_i)
        p.update_attributes position: index
      end
    end

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  def images
    respond_to do |format|
      format.js
    end
  end

  def links
    respond_to do |format|
      format.js
    end
  end

  private
    def add_breadcrumbs_for(p)
      p.parents.push(p).each do |page|
        add_breadcrumb page.title, human_page_path(page.path)
      end
    end
end
