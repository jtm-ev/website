$(document).ready ->
  $('.brand.item.mobile').on 'click', (e) ->
    e.preventDefault()
    $('#nav_menu_dropdown').toggle().transition 'fade up'
    return
  $('#action_toggle').on 'click', (e) ->
    e.preventDefault()
    $('#action_dropdown').toggle().transition 'fade down'
    return
  $('#create_toggle').on 'click', (e) ->
    e.preventDefault()
    $('#create_dropdown').toggle().transition 'fade down'
    return
  $("#navbar_rail").css("top", $("#internal_navbar").height());
  $("#content").css("padding-top", $("#internal_navbar").height()/2+25);
  return

$(window).resize ->
  $("#navbar_rail").css("top", $("#internal_navbar").height());
  $("#content").css("padding-top", $("#internal_navbar").height()/2+25);
  return
