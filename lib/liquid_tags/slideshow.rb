require 'offline_template'

module LiquidTags
  class Slideshow < OfflineTemplate

    def initialize(tag_name, args, tokens)
      super()
    end
  
    def render(context)
      # Rails.logger.info context.environments
      ctx = context.environments.first
      if ctx['page']
        @images = ctx['page'].page_files
      end
    
      render_to_string template: 'application/_slider', layout: nil
    end
  

  end

  Liquid::Template.register_tag('slideshow', Slideshow)
end
