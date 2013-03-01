require 'offline_template'

module LiquidTags
  class Image < OfflineTemplate

    def initialize(tag_name, args, tokens)
      super()
      # Rails.logger.info "Image Tokens: #{tokens.length} : #{tokens}"
    end
  
    def render(context)
      # Rails.logger.info context.environments
      ctx = context.environments.first
      if ctx['page']
        @images = ctx['page'].page_files
      end
    
      # render_to_string template: 'application/_slider', layout: nil
      "<img src='#{@images.first.file.url(:normal)}'>"
    end
  

  end

  Liquid::Template.register_tag('image', Image)
end
