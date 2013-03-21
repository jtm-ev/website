#= require jquery.masonry

jQuery ->
  # $('.portal').sortable {
  #   handle: '.portlet-header'
  # }
  $('.portal').masonry {
    gutterWidth: 0
    itemSelector: '.portlet'
  }
