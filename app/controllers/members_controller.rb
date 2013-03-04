class MembersController < ApplicationController
  load_and_authorize_resource except: [:index]
  
  add_breadcrumb 'Home', :root_path
  
  # GET /members
  # GET /members.json
  def index
    authorize! :manage, Member
    
    @members = Member.scoped.active.order(:name, :first_name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    # @member = Member.find(params[:id])
    
    if params[:project_id]  # Actors of Project
      @project = Project.find(params[:project_id])
      collection = @project.actor_team.members
      
      # @act = collection.find()
      
      
      add_breadcrumb 'Projekte', :projects_path
      add_breadcrumb @project.title, "#{project_path(@project)}#darsteller"
      
      
      
      @previous = @member.previous_in(collection)
      @next = @member.next_in(collection)
    end
    
    add_breadcrumb @member.full_name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    # @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    # @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    # @member = Member.new(params[:member])

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    # @member = Member.find(params[:id])

    if params[:files]
      @member.file = params[:files]
      @member.save
    end

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    # @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
end
