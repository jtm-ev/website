class MembersController < ApplicationController
  load_and_authorize_resource except: [:index, :addresses]
  skip_authorization_check only: [:addresses]
  before_filter :authenticate_user!, except: [:show]
  
  add_breadcrumb 'Home', :root_path
  
  def addresses
    add_breadcrumb 'Adressen'
    @adresses = Member.active
  end
  
  # GET /members/1
  # GET /members/1.json
  def show
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
  
  #############################################################################################
  # Mitgliederverwaltung und Owner
  #############################################################################################

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
        
        process_group_memberships
        
        
        format.html { redirect_to :back, notice: 'Mitgliedsdaten erfolgreich gespeichert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #############################################################################################
  # Mitgliederverwaltung
  #############################################################################################
  
  # GET /members
  # GET /members.json
  def index
    authorize! :manage, Member
    
    if params[:flags] == 'ehemalige'
      scope = Member.scoped.inactive
    elsif params[:flags] == 'alle'
      scope = Member.scoped
    else
      scope = Member.scoped.active
    end
    
    s = sort_column.split(',').map {|s| "#{s} #{sort_direction}"}
    @members = scope.order(s) #.page(params[:all_page]).per(25)
    
    # scope = scope.order(:name, :first_name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end
  
  # GET /members/1/edit
  def edit
    authorize! :manage, Member  # Owner can edit his data using /profile
  end
  
  # GET /members/new
  # GET /members/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # POST /members
  # POST /members.json
  def create
    respond_to do |format|
      if @member.save
        
        process_group_memberships
        
        format.html { redirect_to action: :index, notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
  
  private
    def default_sort_column
      "name"
    end
    
    def process_group_memberships
      del = params[:delete_group_membership]
      del and del.each do |id, value|
        @member.group_memberships.destroy(id.to_i)
      end
      
      gm = params[:new_group_membership]
      if gm and not gm['group_id'].blank?
        @member.group_memberships.create(gm)
      end
    end
end
