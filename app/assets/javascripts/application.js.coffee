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
#= require bootstrap-tab
#= require editing
#= require_tree .

jQuery ->
  # Image-Slider
  # http://dev7studios.com/nivo-slider/#/documentation
  $('.nivoSlider').nivoSlider {
    pauseTime: 5000
  }
  
  $('.tabs a').click (e)->
    target = $(this).attr('href')
    if target[0] is '#'
      e.preventDefault()
      window.location.hash = target
      $(this).tab('show')
    
  $(".tabs a[href='#{window.location.hash}'], .tabs a:first").tab('show')
