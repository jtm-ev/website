class GuestbooksController < ApplicationController
  skip_authorization_check
  before_filter :setup_negative_captcha, :only => [:new, :create]
    
  # GET /guestbooks
  # GET /guestbooks.json
  def index
    @guestbooks = Guestbook.scoped.order('created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guestbooks }
    end
  end

  # # GET /guestbooks/1
  # # GET /guestbooks/1.json
  # def show
  #   @guestbook = Guestbook.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @guestbook }
  #   end
  # end

  # GET /guestbooks/new
  # GET /guestbooks/new.json
  def new
    @guestbook = Guestbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guestbook }
    end
  end

  # # GET /guestbooks/1/edit
  # def edit
  #   @guestbook = Guestbook.find(params[:id])
  # end

  # POST /guestbooks
  # POST /guestbooks.json
  def create
    # @guestbook = Guestbook.new(params[:guestbook])
    @guestbook = Guestbook.new(@captcha.values)

    respond_to do |format|
      if @captcha.valid? && @guestbook.save
        format.html { redirect_to action: :index }
        format.json { render json: @guestbook, status: :created, location: @guestbook }
      else
        format.html { render action: "new" }
        format.json { render json: @guestbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PUT /guestbooks/1
  # # PUT /guestbooks/1.json
  # def update
  #   @guestbook = Guestbook.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @guestbook.update_attributes(params[:guestbook])
  #       format.html { redirect_to action: :index, notice: 'Guestbook was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @guestbook.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /guestbooks/1
  # # DELETE /guestbooks/1.json
  # def destroy
  #   @guestbook = Guestbook.find(params[:id])
  #   @guestbook.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to guestbooks_url }
  #     format.json { head :no_content }
  #   end
  # end
  
  def manage
    authorize! :manage, Guestbook
    
    selection = params[:guestbook][:selection]

    Rails.logger.info "\nMANAGE: #{params.inspect}\n#{selection.inspect}\n"
    
    if params[:delete]
      Guestbook.where(id: selection).delete_all
    elsif params[:assign_project]
      Guestbook.where(id: selection).update_all(project_id: params[:guestbook][:project_id])
    end
    
    redirect_to action: :index
  end
  
  private
    def setup_negative_captcha
      @captcha = NegativeCaptcha.new(
        # A secret key entered in environment.rb. 'rake secret' will give you a good one.
        secret: NEGATIVE_CAPTCHA_SECRET,
        spinner: request.remote_ip, 
        # Whatever fields are in your form
        fields: [:name, :content, :project_id],  
        params: params
      )
    end
end
