class GroupsController < ApplicationController
  load_and_authorize_resource except: [:index]
  before_filter :authenticate_user!, except: [:show]
  skip_authorization_check only: [:index]

  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Gruppen', :groups_path

  # GET /groups
  # GET /groups.json
  def index
    @groups = default_scope

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show

    collection = Group.where(nil).order('name')
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
    add_breadcrumb @group.name
    @next = @group.next_in(default_scope)
    @prev = @group.previous_in(default_scope)
  end

  # POST /groups
  # POST /groups.json
  def create
    respond_to do |format|
      if @group.save
        process_memberships

        format.html { redirect_to edit_group_path(@group) }
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
    group_params = params[:group]
    respond_to do |format|
      if @group.update_attributes(group_params)
        process_memberships

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

  private
    def default_scope
      Group.where(nil).order('public desc, name')
    end

    def process_memberships
      Rails.logger.info "\nProcess: #{params.inspect}\n"
      if params[:add]
        # Create New GroupMembership
        @group.group_memberships.create(params[:new_membership])
      elsif params[:delete]
        @group.group_memberships.where(id: params[:selection]).delete_all
      elsif params[:move]
        new_group = Group.find(params[:move_to_group_id].to_i)
        GroupMembership.where(id: params[:selection]).each do |gm|
          gm.group = new_group
          gm.save
        end
      elsif params[:add_group_leader]
        Member.where(id: params[:add_group_leader_id]).each do |member|
          member.add_role :group_leader, @group
        end
      elsif params[:remove_group_leader]
        Member.where(id: params[:selection]).each do |member|
          member.remove_role :group_leader, @group
        end

      elsif params[:group_memberships]
        # Mass-Update GroupMemberships
        @group.group_memberships.update params[:group_memberships].keys, params[:group_memberships].values
      end
    end


end
