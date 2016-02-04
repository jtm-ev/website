module MetaHelper
  def title(title)
    content_for(:title) do
      title
    end
  end
  
  def meta(hash = {})
    add_meta_tags(hash)
    content_for(:meta) do
      (@meta_tags or {}).map { |key, value|
        # list of meta tags: https://gist.github.com/kevinSuttle/1997924
        identifier = ['og:video'].include?(key) ? 'property' : 'name'
        value.blank? ? nil : "<meta #{identifier}='#{key}' content='#{value}' />"
      }.compact.join.html_safe
    end
  end
  
  def add_meta_tags(hash, namespace = nil)
    @meta_tags ||= {}
    hash.each do |key, value|
      current_name = [namespace, key].compact.join(':')
      if value.is_a?(Hash)
        add_meta_tags(value, current_name)
      else
        @meta_tags[current_name] = value
      end
    end
  end
end