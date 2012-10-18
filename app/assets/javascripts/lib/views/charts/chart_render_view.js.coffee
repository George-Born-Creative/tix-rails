class TixLib.Views.ChartRenderView extends Backbone.View
  
    initialize: (data)->
      console.log 'initialized TixLib.Views.ChartRenderView'
      @chartdata = data.chart
      @setupEvents()
      @setBySectionID = {} # map Raphaël Set to Rails Section ID
      console.log data
      @textElements = []
      @setupTooltip()
      @render()
      
    render: ->
      console.log 'ChartRenderView.render() invoked'
      
      @setChartBackgroundColor( @chartdata.background_color)
      
      @paper = Raphael('chart_container',  500, 700);
      
      self = this
      
      _.each @chartdata.sections, (section)->
        @paper.setStart()
        self.renderSection( section)
        set = @paper.setFinish()
        @setBySectionID[section.id] = set
      , this
      
      _.each @textElements, (el)->
        el.toFront()
        _.each @setBySectionID, (set)->
          set.exclude(el)
      
    setupTooltip: ->
      tip = $('<div id="tooltip"></div>').css
        position : "absolute"
        border : "1px solid gray"
        'background-color' : '#efefef'
        padding : "3px"
        'z-index': "1000"
        'max-width': "200px"
        display: "none"
      .text('hi kids, do you like violence')

      $('#chart_container').parent().prepend(tip)
      
      $(document).mousemove (e)->
        offLeft = e.pageX  -  $('#chart_container').offset().left + 30
        offTop  = e.pageY  - $('#chart_container').offset().top 
        offLeft = if offLeft >= 200 then offLeft - 150 else offLeft
        
        $('#tooltip')
          .css
            "left" : offLeft
            "top": offTop
    
    
        # offLeft = e.pageX  -  this.$el.offset().left + 10
        # offTop  = e.pageY  - this.$el.offset().top - 90
        # 
        # offLeft = if offLeft >= 250 then offLeft - 200 else offLeft
        # 
        # # console.log [wo.left, wo.top, e.pageX, e.pageY, e.pageX-wo.left, e.pageY-wo.top]
        # 
        # Tix.tooltip.attr
        
        
        
    showTooltip: (text)->
      unless window.tix_over
        $('#tooltip')
          .fadeIn('fast')
          .html(text)
          window.tix_over = true
      
      
    hideTooltip: ->
      $('#tooltip').hide()
      window.tix_over = false
    
      
    setupEvents: ->
      self = this
      TixLib.Dispatcher.on 'areaClick', (data)-> 
        console.log '[SR] areaClick event received with data'
        console.log data
        
      TixLib.Dispatcher.on 'sectionColorChange', (data)->
        console.log '[SR] sectionColorChange received with data'
        console.log data
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

      console.log '[SR] Rendering Section ' + section.label
      _.each section.areas, (area)->
        self.renderArea(area, section)
        
    renderArea: (area, section)->
      self = @
      color = if (section.color == undefined || section.color == null || section.color == '') then '#000000' else section.color
      
      raf_shape = null
      switch area.type
        when 'text'
          raf_shape = self.paper.text(area.x, area.y, area.text).attr({'text-anchor': 'start'})
          console.log ["REDNERING TEXT", area.x, area.y, area.text]
          raf_shape.attr
              'fill': '#ffffff'
              'font-size': '15px'
          self.textElements.push(raf_shape)
        when 'circle' # Paper.circle(x, y, r)⚓➭   
          console.log '[SR] Rendering Area Circle ' + area.cx, area.cy, area.r
          raf_shape = self.paper.circle(area.cx, area.cy, area.r)
          raf_shape.attr('fill', color)
          raf_shape.attr('r', 6)
          
        when 'rect' # Paper.rect(x, y, width, height, [r])
          # console.log '[SR] Rendering Rect ' + area.points
        
          raf_shape = self.paper.rect(area.x, area.y, area.width, area.height)
          raf_shape.attr('fill', color)
            
        when 'polygon'
          # console.log '[SR] Rendering Area Points ' + area.points
          raf_shape = self.paper.path("M " + area.points + "z")
      
          raf_shape.attr('fill', color)
    
      try
        unless area.type == 'text'
          raf_shape.attr('stroke', 0)
          raf_shape.click (shape)->
            TixLib.Dispatcher.trigger('areaClick', {area: area, section: section} )
            
            
      if section.seatable
        console.log 'SEATABLE'
        $(raf_shape.node).mouseenter ->
          tmpl = _.template("<strong>Section: {{ section_label }} <br/><strong>Area: {{ area_label }} <br/>")
          rendered = tmpl( {section_label: section.label, area_label: area.label} )
          console.log rendered
          self.showTooltip( rendered )
        .mouseleave ->
          self.hideTooltip()
          
    # drawCircle: ->
    #   
    # drawPoly: ->
    #   
    # drawRect: ->