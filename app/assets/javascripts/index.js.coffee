window.onload = ->
  $('.ui.search').search
    apiSettings: url: '/projekte?search={query}'
    fields:
      results: 'projects'
      title: 'title'
      url: 'html_url'
  return

$ ->
  $('.results').click

jQuery ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_posts_url = $('.pagination a.next_page').attr('href')
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('.pagination').html('<img src="/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $.getScript more_posts_url
      return
    return
