class GuestbooksController < ApplicationController
  skip_authorization_check
  before_filter :setup_negative_captcha, :only => [:new, :create]

  # GET /guestbooks
  # GET /guestbooks.json
  def index
    @guestbooks = Guestbook.all.order('created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guestbooks }
    end
  end

  # GET /guestbooks/new
  # GET /guestbooks/new.json
  def new
    @guestbook = Guestbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guestbook }
    end
  end

  # POST /guestbooks
  # POST /guestbooks.json
  def create
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
        secret: 'aklhkelxjikeakdiekeodl',
        spinner: request.remote_ip,
        # Whatever fields are in your form
        fields: [:name, :content, :project_id],
        params: params
      )
    end
end
