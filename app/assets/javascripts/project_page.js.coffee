$(document).ready ->
  $('.ui.selection.dropdown').dropdown()
  tab = document.getElementById('project_tabs').children[0]
  $(tab).addClass('active')
  tab_content = document.getElementById('project_tabcontent').children[0]
  $(tab_content).addClass('active')
  return
