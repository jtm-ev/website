#= require jquery.masonry

jQuery ->
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
