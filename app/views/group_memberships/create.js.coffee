

html = '<%= (render "item", gms: @group_membership).strip.gsub("\n", '').html_safe %>'
console.log html
jQuery(html).appendTo('#group_memberships_container')