# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require jquery.prettyPhoto
#= require jquery.flexslider
#= require jquery.tablesort
#= require moment
#= require fullcalendar
#= require unitegallery.min.js
#= require ug-theme-tiles.js
#= require ug-theme-carousel.js
#= require editing
#= require calendar
#= require intern
#= require semantic_ui/semantic_ui
#= require scaffolds
#= require index
#= require project_page
#= require guestbooks

$(window).load ->
  $('.menu .item').tab()



jQuery ->
  $("a[rel^='prettyPhoto']").prettyPhoto {
    width: 600
    theme: 'pp_default'
    # social_tools: '<div class="pp_social"><div class="twitter"><a href="http://twitter.com/share" class="twitter-share-button" data-count="none">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></div><div class="facebook"><iframe src="http://www.facebook.com/plugins/like.php?locale=en_US&href='+location.href+'&amp;layout=button_count&amp;show_faces=true&amp;width=500&amp;action=like&amp;font&amp;colorscheme=light&amp;height=23" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:500px; height:23px;" allowTransparency="true"></iframe></div></div>'
    social_tools: '<div class="facebook"><iframe src="http://www.facebook.com/plugins/like.php?href='+location.href+'&amp;layout=button_count&amp;show_faces=true&amp;width=500&amp;action=like&amp;font&amp;colorscheme=light&amp;height=23" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:500px; height:23px;" allowTransparency="true"></iframe></div>'
    # social_tools: false
  }

  # $('.tabs a').click (e)->
  #   target = $(this).attr('href')
  #   if target[0] is '#'
  #     e.preventDefault()
  #     window.location.hash = target
  #     $(this).tab('show')

  # $(".tabs a[href='#{window.location.hash}'], .tabs a:first").tab('show')

  $('#members_table').tablesort();
  $('.alert').delay(5000).fadeOut('fast')
  $('.alert').click (evt)->
    $(evt.currentTarget).alert('close')
