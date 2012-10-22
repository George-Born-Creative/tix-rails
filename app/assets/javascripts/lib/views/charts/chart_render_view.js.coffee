class TixLib.Views.ChartRenderView extends Backbone.View
  
    initialize: (data)->
      #console.log 'initialized TixLib.Views.ChartRenderView'
      @chartdata = data.chart
      @setupEvents()
      @setBySectionID = {} # map Raphaël Set to Rails Section ID
      @elemByAreaID = {} # map of Raphaël elements to Tix area IDs
      #console.log data
      @textElements = []
      @setupTooltip()
      @render()
      
    render: ->
      #console.log 'ChartRenderView.render() invoked'
      
      @setChartBackgroundColor( @chartdata.background_color)
      
      @paper = Raphael('chart_container',  500, 700);
      
      self = this
      
      _.each @chartdata.get('sections'), (section)->
        @paper.setStart()
        self.renderSection( section)
        set = @paper.setFinish()
        @setBySectionID[section.id] = set
      , this
      
      _.each @textElements, (el)->
        el.toFront()
        _.each @setBySectionID, (set)->
          set.exclude(el)
      
      console.log @elemByAreaID
      
      
    disableArea: (area_id)->
      # console.log 'Disabling area ' + area_id
      elem = @elemByAreaID[area_id]
      elem.attr
        'fill': "#333333"
      $(elem.node).unbind()
      $(elem.node).unbind('click')
      
      
      if elem.data('enabled')
        elem.data('enabled', false)

      @hideTooltip()
      
      $('body').css('cursor', 'inherit')
      
      
        
    enableArea: (area_id)->
      # console.log "Enabling area " + area_id
      self = @
      elem = @elemByAreaID[area_id]
      
      # Only enabled if not enabled already 
      # the case whenever (area inventory > 1 )
      if !elem.data('enabled')
        elem.data('enabled', true)
      else
        console.log "Element already enabled"
        return
      
      section = elem.data('section')
      area = elem.data('area')
      color = if area.type == 'text' then '#ffffff' else section.color
      
      elem.attr('fill', color)
      
      $(elem.node).mouseenter ->
        
        tmpl = _.template("<strong>{{ section_label }} <br/><strong>Area: {{ area_label }} <br/>")
        rendered = tmpl
          section_label: section.label
          area_label: area.label
          
        #console.log rendered
        self.showTooltip( rendered )
        $('body').css('cursor', 'pointer')
        
      .mouseleave ->
        self.hideTooltip()
        $('body').css('cursor', 'inherit')
        
      .click (shape)->
        TixLib.Dispatcher.trigger('areaClick', {area: area, section: section} )
      
      
      
    setupTooltip: ->
      tip = $('<div id="tooltip"></div>')
      $('#chart_container').parent().prepend(tip)
      $('#tooltip').css
        position : "absolute"
        border : "1px solid gray"
        'background-color' : '#efefef'
        color: 'black'
        'font-family: "lucida-grande", helvetica'
        padding : "10px"
        margin: '10px'
        'z-index': "5000"
        'max-width': "200px"
        display: "none"
      .text('')
      
      $(document).mousemove (e)->
        offLeft = e.pageX  -  $('#chart_container').offset().left + 20
        offTop  = e.pageY  - $('#chart_container').offset().top  + 200
        offLeft = if offLeft >= 200 then offLeft - 160 else offLeft
        
        $('#tooltip')
          .css
            "left" : offLeft
            "top": offTop
        
        
        
    showTooltip: (text)->
      unless window.tix_over
        $('#tooltip')
          .fadeIn('fast')
          .html(text)
          .css('z-index', '5000')
          
        window.tix_over = true
      
      
    hideTooltip: ->
      $('#tooltip').hide()
      window.tix_over = false
    
      
    setupEvents: ->
      
      self = this
      TixLib.Dispatcher.on 'areaClick', (data)-> 
        # console.log '[SR] areaClick event received with data'
        # console.log data
        
      TixLib.Dispatcher.on 'sectionColorChange', (data)->
        #console.log '[SR] sectionColorChange received with data'
        #console.log data
        set = self.setBySectionID[data.section.id]
        
        set.attr('fill', data.color)
        
      TixLib.Dispatcher.on 'chartColorChange', (data)->
        self.setChartBackgroundColor(data.color)
      
    setChartBackgroundColor: (color)->
      $('#chart_container').css('background-color', color)
      
      
    # Takes a section object and renders Raphaël Objects for each.
    renderSection: (section)->
      self = @
      
      
      section_id = section.id

      #console.log '[SR] Rendering Section ' + section.label
      _.each section.areas, (area)->
        self.renderArea(area, section)
        
    renderArea: (area, section)->
      self = @
      color = if (section.color == undefined || section.color == null || section.color == '') then '#000000' else section.color
      
      raf_shape = null
      
      switch area.type
        when 'text'
          raf_shape = self.paper.text(area.x, area.y, area.text).attr({'text-anchor': 'start'})

          raf_shape.attr
              'fill': '#ffffff'
              'font-size': '15px'
          self.textElements.push(raf_shape)
        when 'circle' # Paper.circle(x, y, r)⚓➭   
          #console.log '[SR] Rendering Area Circle ' + area.cx, area.cy, area.r
          raf_shape = self.paper.circle(area.cx, area.cy, area.r)
          #raf_shape.attr('fill', color)
          raf_shape.attr('r', 6)
          
        when 'rect' # Paper.rect(x, y, width, height, [r])
          # console.log '[SR] Rendering Rect ' + area.points
        
          raf_shape = self.paper.rect(area.x, area.y, area.width, area.height)
          #raf_shape.attr('fill', color)
            
        when 'polygon'
          # console.log '[SR] Rendering Area Points ' + area.points
          raf_shape = self.paper.path("M " + area.points + "z")
      
          #raf_shape.attr('fill', color)
    
      try
        unless area.type == 'text'
          raf_shape.attr('stroke', 0)
      
      raf_shape.data('section', section)
      raf_shape.data('area', area)
      
      self.elemByAreaID[area.id] = raf_shape
          
      if section.seatable && (area.inventory > 0) || area.type == 'text'
        self.enableArea(area.id)
      else
        self.disableArea(area.id)
        
      
          
    # drawCircle: ->
    #   
    # drawPoly: ->
    #   
    # drawRect: ->