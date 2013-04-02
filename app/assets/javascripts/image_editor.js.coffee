#= require jquery
#= require jquery.Jcrop

class ImageEditor
  constructor : (@name, @ratio)->
    @target = $("#image-#{@name}")
    # @ratio = 16.0/9.0
    
    @width  = @target.data('width')
    @height = @target.data('height')
    @landscape = @width > @height
    
    if @ratio is 1
      @sW = Math.min(@width, @height)
    else
      @sW = @width
    
    @sH = @width / @ratio
    
    @sY = (@height - @sH) / 2
    @sX = (@width - @sW) / 2
    
    # console.log "Sel: ", @ratio, @height, @width, @sW, @sH, @sY
    console.log "Sel: ", @sX
    
    @target.Jcrop({
      # boxWidth: 300
      boxHeight: 300
      aspectRatio: @ratio
      onChange: @update
      onSelect: @update
      bgOpacity: 0.2
      setSelect: [@sX, @sY, @sW, @sH]
      minSize: [@sW, @sH]
      # minHeight: @sH
    })
    
  update : (@coords)=>
    # console.log 
    # @preview(c)
    
  preview : (coords)=>
    if coords
      rx = 300 / coords.w
    	ry = 300 / coords.h

    	$('#preview').css({
    	  width: 300
        # width: Math.round(rx * @width) + 'px',
        # height: Math.round(ry * @height) + 'px',
        # marginLeft: '-' + Math.round(rx * coords.x) + 'px',
        # marginTop: '-' + Math.round(ry * coords.y) + 'px'
    	})
  

jQuery ->
  console.log 'start image editor'
  window.image_editors = [
    new ImageEditor('cinema', 16/9)
    new ImageEditor('square', 1)
  ]
  
  $('#save').click ->
    console.log 'save'
    data = {}
    for e in window.image_editors
      data[e.name] = e.coords
      
    console.log data
    id = $('.data').data('id')
    xhr = $.post "/project_files/#{id}/crop", {crop: data}, (data, textStatus, xhr)->
      console.log data, textStatus
      
      
      
      