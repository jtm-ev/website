class LocationsController < ApplicationController
  load_and_authorize_resource except: [:index]
  
  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Spielorte', :locations_path
  
  def manage
    params[:ids].split(',').each_with_index do |id, pos|
      o = Location.find(id)
      o.update_attributes position: pos
    end
    redirect_to action: :index
  end
  
  # GET /locations
  # GET /locations.json
  def index
    @locations = default_scope
    authorize! :read, Location

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show

    add_breadcrumb @location.name
    
    @previous = @location.previous_in(default_scope)
    @next = @location.next_in(default_scope)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
  
  private
    def default_scope
      Location.order(:position)
    end
end
