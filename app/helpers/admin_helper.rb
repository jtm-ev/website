
module AdminHelper
  def admin_panel_for(resource, &block)
    if can?(:manage, resource)
      content_tag :div, capture(&block), class: 'admin-panel'
    end
  end
end