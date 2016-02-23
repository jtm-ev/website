$(document).ready ->
  $('.ui.selection.dropdown').dropdown()
  $('.menu .item').tab()
  return

$(window).load ->
  $('#carousel').flexslider
    animation: 'slide'
    controlNav: false
    smoothHeight: true
    animationLoop: false
    slideshow: false
    itemWidth: 210
    itemMargin: 5
    asNavFor: '#slider'
  $('#slider').flexslider
    animation: 'slide'
    smoothHeight: true
    controlNav: false
    animationLoop: true
    slideshow: true
    sync: '#carousel'
  return
