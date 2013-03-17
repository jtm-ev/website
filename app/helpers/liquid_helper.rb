
module LiquidHelper
  require_dependency 'offline_template'
  require_dependency 'liquid_tags/project_slideshow'
  require_dependency 'liquid_tags/slideshow'
  require_dependency 'liquid_tags/image'
  require_dependency 'liquid_tags/group_member_grid'
  require_dependency 'liquid_tags/group_list'
  
  def liquidize(content, arguments)
    # RedCloth.new(Liquid::Template.parse(content).render(arguments, :filters => [LiquidFilters])).to_html
    Liquid::Template.parse(content).render(arguments).html_safe
  end
end