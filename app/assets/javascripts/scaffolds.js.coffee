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

  if ($("#mobile_nav_content").css('display') == 'flex')
    $("#internal_navbar").css("top", $("#mobile_navbar").height());
    $('#nav_menu_dropdown').css('top', $("#mobile_navbar").height()+2)
  else
    $("#internal_navbar").css("top", 0);
  $("#navbar_rail").css("top", $("#internal_navbar").height());
  $("#content").css("padding-top", $("#internal_navbar").height()/2+25);
  return

$(window).resize ->
  if ($("#mobile_nav_content").css('display') == 'flex')
    $("#internal_navbar").css("top", $("#mobile_navbar").height());
  else
    $("#internal_navbar").css("top", 0);
  $("#navbar_rail").css("top", $("#internal_navbar").height());
  $("#content").css("padding-top", $("#internal_navbar").height()/2+25);
  return
