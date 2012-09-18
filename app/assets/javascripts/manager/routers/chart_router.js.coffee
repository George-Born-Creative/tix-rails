class TixMgr.Routers.ChartRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
  
  
  initialize: (data)->
      
    view = new TixMgr.Views.ChartEditorView({chart: data.chart})
    view.render()
    
  index: ->
    
    
    