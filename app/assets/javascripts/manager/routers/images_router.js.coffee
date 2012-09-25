class TixMgr.Routers.ImagesRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
  
  
  initialize: (data)->
    index_view = new TixMgr.Views.ImagesIndexView()
    
    
    
  index: ->
    
    
