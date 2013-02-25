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
     image.file.url(:large)
    end
  end
end
