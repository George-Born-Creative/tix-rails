class TixLib.Views.ChartRenderView extends Backbone.View
  
    initialize: (data)->
      console.log 'initialized TixLib.Views.ChartRenderView'
      @chartdata = data.chart
      @setupEvents()
      @setBySectionID = {} # map Raphaël Set to Rails Section ID
      console.log data
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
      
      color = if (section.color == undefined || section.color == null || section.color == '') then '#000000' else section.color
      
      section_id = section.id
      console.log '[SR] Rendering Section ' + section.label
      _.each section.areas, (area)->
        raf_shape = null
        switch area.type
                  
          when 'circle' # Paper.circle(x, y, r)⚓➭   
            console.log '[SR] Rendering Area Circle ' + area.cx, area.cy
            raf_shape = self.paper.circle(area.cx, area.cy, area.r)
            raf_shape.attr('fill', color)
            
          when 'rect' # Paper.rect(x, y, width, height, [r])
            console.log '[SR] Rendering Rect ' + area.points
          
            raf_shape = self.paper.rect(area.x, area.y, area.width, area.height)
            raf_shape.attr('fill', color)
              
          when 'polygon'
            console.log '[SR] Rendering Area Points ' + area.points
            raf_shape = self.paper.path("M " + area.points + "z")
        
            raf_shape.attr('fill', color)
      
        try
          raf_shape.attr('stroke', 0)
          raf_shape.click (shape)->
            TixLib.Dispatcher.trigger('areaClick', {area: area, section: section} )
            
    # drawCircle: ->
    #   
    # drawPoly: ->
    #   
    # drawRect: ->