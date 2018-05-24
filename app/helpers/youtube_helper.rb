module YoutubeHelper
  def youtube_embed(url)
    id = youtube_id(url)
  	%Q{<iframe class='youtube' title="YouTube video player" width="428" height="320" src="//www.youtube.com/embed/#{ id }" frameborder="0" allowfullscreen></iframe>}
  end

  def youtube_image(url)
    "//img.youtube.com/vi/#{youtube_id(url)}/0.jpg"
  end

  def youtube_id(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
	    return $1
	  else
	    # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
	    youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
	    return $5
	  end
  end


end
