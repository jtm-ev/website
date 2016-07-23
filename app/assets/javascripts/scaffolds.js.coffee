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

  $("#navbar_rail").css("margin-left", ($(window).width()-977)*0.1);
  if ($("#mobile_nav_content").css('display') == 'flex')
    $("#internal_navbar").css("top", $("#mobile_navbar").height());
    $('#nav_menu_dropdown').css('top', $("#mobile_navbar").height()+2)
    $("#content").css("margin-left", 0);
  else
    $("#internal_navbar").css("top", 0);
    $("#content").css("margin-left", $("#navbar_rail").outerWidth( false ));
  $("#navbar_rail").css("top", $("#internal_navbar").height());
  $('#create_dropdown').css('margin-top', $("#internal_navbar").height()+2)
  $("#content").css("padding-top", $("#internal_navbar").height()/2+25);
  return

$(window).resize ->
  $("#navbar_rail").css("margin-left", ($(window).width()-977)*0.1);
  if ($("#mobile_nav_content").css('display') == 'flex')
    $("#internal_navbar").css("top", $("#mobile_navbar").height());
    $("#content").css("margin-left", 0);
  else
    $("#internal_navbar").css("top", 0);
    $("#content").css("margin-left", $("#navbar_rail").outerWidth( false ));
  $("#navbar_rail").css("top", $("#internal_navbar").height());
  $('#create_dropdown').css('margin-top', $("#internal_navbar").height()+2)
  $("#content").css("padding-top", $("#internal_navbar").height()/2+25);
  return
