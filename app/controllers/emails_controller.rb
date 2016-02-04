class EmailsController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check
  skip_before_filter :verify_authenticity_token

  # GET /emails/new
  # GET /emails/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    to = params[:email].join(',').split(',').uniq.join(',')
    mail = InternMailer.email(current_user, to, params[:email_subject], params[:email_content])
    mail.deliver
  end

end
