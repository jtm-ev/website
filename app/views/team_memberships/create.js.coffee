html = '<%= (render "item", team_membership: @team_membership).strip.gsub("\n", '').html_safe %>'
jQuery(html).appendTo('#team_memberships_container')