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
#= require jquery.nivo.slider
#= require jquery.prettyPhoto
#= require bootstrap-tab
#= require bootstrap-alert
#= require editing
#= require intern
#= require_tree .

jQuery ->
  # Image-Slider
  # http://dev7studios.com/nivo-slider/#/documentation
  $('.nivoSlider').nivoSlider {
    pauseTime: 5000
    controlNavThumbs: true
  }
  
  $("a[rel^='prettyPhoto']").prettyPhoto {
    width: 600
    theme: 'pp_default'
    # social_tools: '<div class="pp_social"><div class="twitter"><a href="http://twitter.com/share" class="twitter-share-button" data-count="none">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script></div><div class="facebook"><iframe src="http://www.facebook.com/plugins/like.php?locale=en_US&href='+location.href+'&amp;layout=button_count&amp;show_faces=true&amp;width=500&amp;action=like&amp;font&amp;colorscheme=light&amp;height=23" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:500px; height:23px;" allowTransparency="true"></iframe></div></div>'
    social_tools: '<div class="facebook"><iframe src="http://www.facebook.com/plugins/like.php?href='+location.href+'&amp;layout=button_count&amp;show_faces=true&amp;width=500&amp;action=like&amp;font&amp;colorscheme=light&amp;height=23" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:500px; height:23px;" allowTransparency="true"></iframe></div>'
    # social_tools: false
  }
  
  $('.tabs a').click (e)->
    target = $(this).attr('href')
    if target[0] is '#'
      e.preventDefault()
      window.location.hash = target
      $(this).tab('show')
    
  $(".tabs a[href='#{window.location.hash}'], .tabs a:first").tab('show')
  
  
  # $('.alert').delay(3000).fadeOut('fast')
  
  $('.sticky').each (index, item)->
    i = $(item)
    p = i.parent()
    
    $(window).scroll ->
      iH = i.height()
      pH = p.height()
      
      margin = 43
      offset = p.offset().top - margin - $(window).scrollTop()
      
      new_top = 0
      if offset < 0
        new_top = offset * -1
      
      if (new_top + iH) > pH
        new_top = pH - iH
        
      i.css 'top', new_top
  
  