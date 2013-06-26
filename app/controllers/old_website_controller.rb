
class OldWebsiteController < ApplicationController
  skip_authorization_check
  
  def redirect
    case params[:nav]
      when "do|der_verein|gruppen"
        redirect_permanent '/s/gruppen'
      when "do|der_verein|gruppen|gaukler"
        redirect_permanent '/s/gaukler'
      when "do|kontakt"
        redirect_permanent '/s/kontakt'
      when "do|kontakt|gaestebuch"
        redirect_permanent '/gaestebuch'
      when "do|kontakt|impressum"
        redirect_permanent '/s/kontakt/impressum'
      when "do|sponsoren"
        redirect_permanent '/s/sponsoren'
      when /projekte/
        redirect_permanent "/projekte/#{params[:stueck_id]}"
      when /jtm\-hilft/
        redirect_permanent "/s/der-verein/jtm-hilft"
      else
        if Rails.env.production?
          redirect_to :root
        else
          render text: 'redirect_to root'
        end
    end
  end
  
  def redirect_image
    case params[:path]
      when /uploads\/projekte\/(\d*)\//
        redirect_permanent "/projekte/#{$1}"
      else
        if Rails.env.production?
          redirect_to :root
        else
          render text: "Image: #{params[:path]}"
        end
    end
  end
  
  private
    def redirect_permanent(url)
      redirect_to url, :status => :moved_permanently
    end
end

# www.jtm.de/uploads/presse/momo.pdf‎