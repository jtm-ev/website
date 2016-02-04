xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

	# More Info: http://support.google.com/webmasters/bin/answer.py?hl=en&answer=183668

  xml.url do
    xml.loc "http://www.jtm.de"
		# xml.lastmod "2009-09-22"
    # xml.priority 1.0
  end

  # @categories.each do |category|
  #   xml.url do
  #     xml.loc category_url(category)
  #     xml.priority 0.9
  #   end
  # end
  # 
  # @posts.each do |post|
  #   xml.url do
  #     xml.loc post_url(post)
  #     xml.lastmod post.updated_at.to_date
  #     xml.priority 0.9
  #   end
  # end

end