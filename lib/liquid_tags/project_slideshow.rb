require 'offline_template'

module LiquidTags

  class ProjectSlideshow < OfflineTemplate #Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      super()
      # Rails.logger.info "Slideshow: #{markup}"
      # Rails.logger.info "Token: #{tokens}"
      
      args = markup.split(' ')
      
      
      @project_id = args.first.to_i
      @show_thumbnails = args.second.nil? ? false : (args.second == 'true')
      
      # Rails.logger.info "Args: #{@project_id} : #{@show_thumbnails}"
      
      @project = Project.find @project_id
    end
    
    def render(context)
      # Rails.logger.info context.environments
      @images = @project.images
      render_to_string template: 'application/_slider', layout: nil
    end
    
  end
    
  Liquid::Template.register_tag('project_slideshow', ProjectSlideshow)
end