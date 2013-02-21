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
    $item.fileupload {
      type: 'POST'
      dataType: 'json'
      dropZone: $item
      pasteZone: null   # for File Upload via Copy&Paste
      formData: {}
      # paramName: 'files[]'
      add: (e, data)->
        console.log "Add File", data
        data.submit()
      done: (e, data)->
        console.log "Done", data
      fail: (e, data)->
        console.log "Upload Fail", e, data
      drop: (e, data)->
        console.log "Something Dropped", data
      # dragover: (e, data)->
      #   console.log "Drag Over", data
      progressall: (e, data)->
        console.log "Progress", data.loaded, data.total      
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
  