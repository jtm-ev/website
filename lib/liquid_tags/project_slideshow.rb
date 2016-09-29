# require 'offline_template'

module LiquidTags

  class ProjectSlideshow < Liquid::Tag
    def initialize(tag_name, markup, tokens)

       args = markup.split(' ')


       @project_id = args.first.to_i
       @show_thumbnails = args.second.nil? ? false : (args.second == 'true')
       @project = Project.find @project_id
       # Rails.logger.info "Args: #{@project_id} : #{@show_thumbnails}"

     end

    def render(context)
      ac = ActionController::Base.new()
      @images = @project.images
      ac.render_to_string(partial: 'application/slider', :locals => {:@images => @images})
    end

  end

  Liquid::Template.register_tag('project_slideshow', ProjectSlideshow)
end
