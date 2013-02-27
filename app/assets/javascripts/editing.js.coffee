#= require wysihtml5
#= require_tree ./wysihtml5
# require parser_rules/advanced
#= require jquery-fileupload/basic
#= require bootstrap-dropdown
#= require select2
#= require jquery-ui
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
      $dropZone.click ->
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
        if $item.data('reload')
          
          window.location.reload()
      fail: (e, data)->
        console.log "Upload Fail", e, data
      drop: (e, data)->
        console.log "Something Dropped", data
      # dragover: (e, data)->
      #   console.log "Drag Over", data
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
  $('select').select2 {
    
  }
  
  # Input Focus
  $('input[type=text]').first().focus()
  
  # Image Sorting
  $('.sortable-images').sortable {
    items: '> img'
    update: (event, ui)->
      parent = ui.item.parent()
      input = parent.find('input')
      ids = parent.find('> img').map (index, item)->
        $(item).data('id')
      
      input.val ids.toArray().join(',') 
  }
  
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
      console.log 'sort'
  }
  
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
  
  
  
  