class TixMgr.Routers.ImagesRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
  
  
  initialize: (data)->
    index_view = new TixMgr.Views.ImagesIndexView()
    
    
    
  index: ->
    
  
  ########
  disableOther: ->
    $('input[type="checkbox"].disable-other').change ->
      alert('changed', this.val())
    
    
