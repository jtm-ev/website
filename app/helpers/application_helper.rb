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
  
  def youtube_embed(youtube_url)
	  if youtube_url[/youtu\.be\/([^\?]*)/]
	    youtube_id = $1
	  else
	    # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
	    youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
	    youtube_id = $5
	  end

  	%Q{<iframe class='youtube' title="YouTube video player" width="428" height="320" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
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
  
  def liquidize(content, arguments)
    # RedCloth.new(Liquid::Template.parse(content).render(arguments, :filters => [LiquidFilters])).to_html
    Liquid::Template.parse(content).render(arguments).html_safe
  end
  
  def with_clamps_unless_nil(text)
    text.nil? ? '' : " (#{text})"
  end
  
end
