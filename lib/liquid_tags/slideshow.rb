# require 'offline_template'

module LiquidTags
  class Slideshow < Liquid::Tag

    def render(context)
      ctx = context.environments.first
      if ctx['page']
        @images = ctx['page'].page_files
      end
      ac = ActionController::Base.new()
      ac.render_to_string(partial: 'application/gallery', :locals => {:@images => @images})
    end


  end

  Liquid::Template.register_tag('slideshow', Slideshow)
end
