# require 'offline_template'

module LiquidTags
  class Slideshow < Liquid::Tag

    # def initialize(tag_name, args, tokens)
    #   super()
    # end

    # def render(context)
    #   # Rails.logger.info context.environments
    #   ctx = context.environments.first
    #   if ctx['page']
    #     @images = ctx['page'].page_files
    #   end

    #   render_to_string template: 'application/_slider', layout: nil
    # end

    def parse(tokens)
      @body = '[TODO: lib/liquid_tags/slideshow]'
    end

    def render(context)
      @body
    end


  end

  Liquid::Template.register_tag('slideshow', Slideshow)
end
