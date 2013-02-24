#= require wysihtml5
#= require_tree ./wysihtml5
# require parser_rules/advanced
#= require jquery-fileupload/basic
#= require bootstrap-dropdown
#= require select2
#= require jquery-ui

jQuery ->
  # Handle File Uploads
  # https://github.com/blueimp/jQuery-File-Upload/wiki/Options
  $('.fileupload').each (index, item)->
    $item = $(item)
    dropZoneSelector = $item.data('dropzone')
    $dropZone = if dropZoneSelector then $(dropZoneSelector) else $item
    
    if $dropZone != $item
      $item.css 'display', 'none'
      
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
  