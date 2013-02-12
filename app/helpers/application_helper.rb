module ApplicationHelper
  def navigation_link_to(text, href)
    tag_class = (href == request.path) ? 'active' : ''
    content_tag :li, class: tag_class do
      content_tag :a, href: href do
        text
      end
    end
  end
end
