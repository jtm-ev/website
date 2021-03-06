require 'offline_template'

module LiquidTags

  class GroupList < OfflineTemplate #Liquid::Tag
    
    def initialize(tag_name, markup, tokens)
      super()
      args = markup.split(' ')

      @kind = args.first
      @groups = Group.public.where(category: @kind)
    end
    
    def render(context)
      render_to_string template: 'groups/_list', layout: nil      
    end
    
  end
  
  class GroupGrid < GroupList
    def render(context)
      render_to_string template: 'groups/_grid', layout: nil
    end
  end
    
  Liquid::Template.register_tag('group_list', GroupList)
  Liquid::Template.register_tag('group_grid', GroupGrid)
end