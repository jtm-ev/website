# require 'offline_template'

module LiquidTags
  class Image < Liquid::Tag

    # def initialize(tag_name, args, tokens)
    #   super()
    #   # Rails.logger.info "Image Tokens: #{tokens.length} : #{tokens}"
    # end

    # def render(context)
    #   # Rails.logger.info context.environments
    #   ctx = context.environments.first
    #   if ctx['page']
    #     @images = ctx['page'].page_files
    #   end

    #   # render_to_string template: 'application/_slider', layout: nil
    #   "<img src='#{@images.first.file.url(:normal)}'>"
    # end

    def parse(tokens)
      @body = '[TODO: lib/liquid_tags/image]'
    end

    def render(context)
      @body
    end


  end

  Liquid::Template.register_tag('image', Image)
end
