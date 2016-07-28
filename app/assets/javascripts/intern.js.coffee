#= require jquery.masonry

jQuery ->
  $('.ui.dropdown').dropdown()
  # $('.portal').sortable {
  #   handle: '.portlet-header'
  # }
  $('.portal').masonry {
    gutterWidth: 0
    itemSelector: '.portlet'
  }

  $( ".accordion" ).accordion {
    header: '.accordion-header'
    heightStyle: "fill"
  }
