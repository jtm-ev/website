# require 'offline_template'

module LiquidTags
  class GroupMemberGrid < Liquid::Tag

     def render(context)
       ac = ActionController::Base.new()
       # Rails.logger.info context.environments
       ctx = context.environments.first
       if ctx['page']
         page = ctx['page']
         @group = page.group
         if @group
           return ac.render_to_string(partial: 'groups/members', :locals => {:@group => @group})
         end
       end

     end


  end

  Liquid::Template.register_tag('group_member_grid', GroupMemberGrid)
end
