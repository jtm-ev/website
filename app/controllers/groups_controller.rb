class GroupsController < ApplicationController
  load_and_authorize_resource except: [:index]
  
  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Gruppen', :groups_path

  # GET /groups
  # GET /groups.json
  def index
    authorize! :manage, Group
    
    @groups = Group.scoped.order('name')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    
    collection = Group.scoped.order('name')
    @previous = @group.previous_in(collection)
    @next = @group.next_in(collection)

    add_breadcrumb @group.name

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    
    if params[:add]
      # Create New GroupMembership
      @group.group_memberships.create(params[:new_membership])
    elsif params[:delete]
      # Delete Selection
      selection_ids = params[:selection].map {|s| s.to_i}
      GroupMembership.delete( selection_ids )
    else
      # Mass-Update GroupMemberships
      @group.group_memberships.update params[:group_memberships].keys, params[:group_memberships].values
    end

    group_params = params[:group]
    respond_to do |format|
      if @group.update_attributes(group_params)
        format.html { redirect_to :back }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end
end
