#= require tinymce-jquery
#= require jquery-fileupload/basic
#= require bootstrap-dropdown
#= require select2
#= require jquery
#= require jquery.ui.all
#= require bootstrap-datepicker

# require jquery.mjs.nestedSortable
# require bootstrap-colorpicker

jQuery ->
  # Handle File Uploads
  # https://github.com/blueimp/jQuery-File-Upload/wiki/Options
  $('.fileupload').each (index, item)->
    $item = $(item)
    dropZoneSelector = $item.data('dropzone')
    $dropZone = if dropZoneSelector then $(dropZoneSelector) else $item
    
    if $dropZone != $item
      $item.css 'display', 'none'  
      $dropZone.click (e)->
        e.preventDefault()
        $item.click()
      
    $item.fileupload {
      type: $item.data('method') or 'POST'
      dataType: 'json'
      dropZone: $dropZone
      pasteZone: null   # for File Upload via Copy&Paste
      formData: {}
      # paramName: 'files[]'
      add: (e, data)->
        console.log "Add File", data
        # $(document.body).addClass 'uploading'
        data.submit()
      done: (e, data)->
        console.log "Done", data
      fail: (e, data)->
        console.log "Upload Fail", e, data
      drop: (e, data)->
        console.log "Something Dropped", data
      # dragover: (e, data)->
      #   console.log "Drag Over", data
      start: (e, data)->
        $dropZone.addClass 'uploading'
      stop: (e, data)->
        $dropZone.removeClass 'uploading'
        if $item.data('reload')
          window.location.reload()
      progressall: (e, data)->
        console.log "Progress", data.loaded, data.total
        percentage = 100.0 / data.total * data.loaded
        $dropZone.find('.progress .bar').css 'width', "#{percentage}%"
        # $(document.body).toggleClass 'uploading', (data.loaded != data.total)  
    }

  # Disable Browser Defaults for File Drop
  $(document).bind 'drop dragover', (e)->
    e.preventDefault()
    
  # Dropdowns
  $('.dropdown-toggle').dropdown()
  
  # Tags
  $('input.tags').select2 {
    tags: []
    tokenSeparators: [',']
  }
  
  # Selects
  $('select:not(.filter)').select2 {
    
  }
  
  # Filter
  $('.filter').change (evt)->
    $target = $(evt.currentTarget)
    $(document.body).attr( "data-#{$target.data('filter')}-filter", $target.val())
  
  # Input Focus
  $('input[type=text]').first().focus()
  
  # Image Sorting
  # $('.sortable-images').sortable {
  #   items: '> img'
  #   update: (event, ui)->
  #     parent = ui.item.parent()
  #     input = parent.find('input')
  #     ids = parent.find('> img').map (index, item)->
  #       $(item).data('id')
  #     
  #     input.val ids.toArray().join(',') 
  # }
  
  # Page Sorting
  $('.sortable-pages').sortable {
    items: '> li'
    update: (event, ui)->
      parent = ui.item.parent()
      input = parent.find('input')
      ids = parent.find('> li').map (index, item)->
        $(item).data('id')
      
      input.val ids.toArray().join(',')
  }
  
  $('.multifile-upload').sortable {
    items: '> .file:not(.drop-target)'
    update: (event, ui)->
      parent = ui.item.parent()
      input = parent.find('input[type=hidden]')
      ids = parent.find('> [data-id]').map (index, item)->
        $(item).data('id')
      
      input.val ids.toArray().join(',')
  }
  
  # Table sorting
  $('table.sortable tbody').sortable({
    helper: (e, ui)->
      ui.children().each ->
        $(this).width($(this).width())
      return ui;
    update: (event, ui)->
      parent = ui.item.parent()
      input = $($(this).data('sort-target')) #parent.find('input')

      ids = parent.find('> tr').map (index, item)->
        $(item).data('id')
      
      id_val = ids.toArray().join(',')
      input.val id_val
      
  }).disableSelection()
  
  # Datepicker
  $('.datepicker').datepicker()
  
  # $('.sortable-tree').nestedSortable {
  #   handle: 'div'
  #   items: 'li'
  #   toleranceElement: '> div'
  #   update: (event, ui)->
  #     console.log "STOP SORT: ", event, ui
  # }
  
  # Color
  # $('.color').colorpicker {
  #   format: 'rgba'
  # }
  
  
  
  