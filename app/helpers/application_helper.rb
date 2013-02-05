module ApplicationHelper
  def navigation_link_to(text, href)
    tag_class = (href == request.path) ? 'active' : ''
    content_tag :a, href: href, class: tag_class do
      text
    end
  end
end
