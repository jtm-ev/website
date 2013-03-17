require 'offline_template'

module LiquidTags
  class GroupMemberGrid < OfflineTemplate

    def initialize(tag_name, args, tokens)
      super()
    end
  
    def render(context)
      # Rails.logger.info context.environments
      ctx = context.environments.first
      if ctx['page']
        page = ctx['page']
        @group = page.group
        if @group
          return render_to_string template: 'groups/_members'
        end
      end
    
      # render_to_string template: 'application/_slider', layout: nil
      ''
    end
  

  end

  Liquid::Template.register_tag('group_member_grid', GroupMemberGrid)
end
