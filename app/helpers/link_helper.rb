module LinkHelper
  def link_to_active(link_text, link_path, shown = false)
    if (shown)
      fullpath = URI.unescape(request.fullpath)
      if link_path.include? ":" and fullpath.include? ":"
        class_name = (current_page?(link_path)) ? 'active item' : 'item'
      end
      if !(link_path.include? ":") and fullpath.include? ":" and link_text != 'Alle' and link_text != 'Aktive'
        class_name = (current_page?(link_path) || (URI.unescape(request.fullpath.split(/:/).first)) == (link_path.split(/:/).first)) ? 'active item' : 'item'
      else
        class_name = (current_page?(link_path)) ? 'active item' : 'item'
      end

      link_to link_text, link_path, class: class_name
    end
  end
end
