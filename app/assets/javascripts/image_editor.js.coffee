#= require jquery
#= require jquery.Jcrop
#= require bootstrap-modal

class ImageEditor
  constructor: (@name, @ratio)->
    @target = $("#image-#{@name}")
    # @ratio = 16.0/9.0
  
  load: (@data, @org)=>
    @target.html ''
    @img = jQuery("<img src='#{@data.url}' style='' />")
    @img.appendTo(@target)
    
    @img.on 'load', @jcrop
    # setTimeout @jcrop, 500
    # @jcrop()
    
  jcrop: =>
    console.log @img
    
    @width  = @data.width
    @height = @data.height
    @landscape = @width > @height
    
    if @ratio is 1
      @sH = @sW = Math.min(@width, @height)
      @sX = 0 #(@width / 2) / (@height / 300)
      @sY = 0
    else
      @sW = @width
      @sH = @width / @ratio
    
      @sX = 0 #(@width - @sW) #/ 2
      @sY = 0 #(@height - @sH) / 2

    console.log "Sel: ", @sX, @sY, @sW, @sH, @width, @height, @ratio

    @img.Jcrop({
      boxHeight: 300
      aspectRatio: @ratio
      onChange: @update
      onSelect: @update
      bgOpacity: 0.2
      setSelect: [@sX, @sY, @sW, @sH]
      # minSize: [@sW, @sH]
    })
    
  refresh: =>
    if @org
      @org.find('img').each (index, img)->
        img = $(img)
        org_src = img.attr('src')
        img.attr 'src', ''
        img.attr 'src', (org_src.replace(/\?(\d+)/, '?' + new Date().getTime()))
      
  update: (@coords)=>
    # console.log 
    # @preview(c)
    
  # preview : (coords)=>
  #   if coords
  #     rx = 300 / coords.w
  #     ry = 300 / coords.h
  # 
  #     $('#preview').css({
  #       width: 300
  #       # width: Math.round(rx * @width) + 'px',
  #       # height: Math.round(ry * @height) + 'px',
  #       # marginLeft: '-' + Math.round(rx * coords.x) + 'px',
  #       # marginTop: '-' + Math.round(ry * coords.y) + 'px'
  #     })
  

jQuery ->
  # $('#image-cropper').modal()
  
  console.log 'start image editor'
  window.image_editors = [
    new ImageEditor('cinema', 16/9)
    new ImageEditor('square', 1)
  ]
  
  $('#image-list .image-group').on 'click', (evt)->
    target = $(evt.target)
    data = target.data()
    for e in window.image_editors
      e.load(data, target)
    $('#image-cropper').modal('show')
  
  $('#save').click ->
    console.log 'save'
    data = {}
    for e in window.image_editors
      data[e.name] = e.coords
      id = e.data.id
      
    console.log data
    # id = $('.data').data('id')
    xhr = $.post "/project_files/#{id}/crop", {crop: data}, (data, textStatus, xhr)->
      console.log data, textStatus
      
      $('#image-cropper').modal('hide')
    
      for e in window.image_editors
        e.refresh()
      
      
      