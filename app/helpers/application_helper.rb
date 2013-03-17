module ApplicationHelper
  def navigation_link_to(text, href, start_match = false)
    if start_match
      tag_class = request.path.match(/^#{href}/) ? 'active' : ''
    else
      tag_class = request.path == href ? 'active' : ''
    end
    
    content_tag :li, class: tag_class do
      content_tag :a, href: href do
        text
      end
    end
  end
 
  def set_background(image)
    return unless image
    content_for :background do 
     image.file.url(:square_300)
    end
  end
  
  def tree_item(page)
    html = "<li><div>#{page.position}: #{page.title}</div>"
    if page.has_children?
      html << "<ol>"
        page.children.each do |child|
          html << tree_item(child)
        end
      html << "</ol>"
    end
    html << "</li>"
    return html.html_safe
    
    # content_tag :li do
    #   result = []
    #   result << content_tag(:div) do
    #     page.title
    #   end
    #   if page.has_children?
    #     result << content_tag(:ol) do
    #       page.children.each do |child|
    #         tree_item(child)
    #       end
    #     end
    #   end
    #   result.join.html_safe
    # end
    
  end
  
  def render_breadcrumbs
    content_tag :div, id: 'breadcrumbs' do
      super
    end
  end
  
  def render_navigatable_nav(item, text, link, title_sym)
    return text.html_safe if item.nil?
    link_to text.html_safe, link.call(item), {title: item.try(title_sym)}
  end
  

  
  def with_clamps_unless_nil(text)
    text.blank? ? '' : " (#{text})"
  end
  
  def sortable_column(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == :asc ? "desc" : "asc"
    link_to title, params.merge({:sort => column, :direction => direction}), {:class => css_class}
  end
  
  def link_to_if_true(href, is_true = true, &block)
    if is_true
      content_tag :a, capture(&block), href: href
    else
      capture(&block)
    end
  end
  
end
