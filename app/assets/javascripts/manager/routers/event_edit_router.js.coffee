class TixMgr.Routers.EventEditRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
  
  initialize: (data)->
    $('.datepicker').datepicker
      format: 'mm-dd-yyyy'
    .on 'changeDate', (e)->
      console.log '[SQUiiD changeDate fired]'
      
    $('.timepicker').timepicker
      modalBackdrop: true
      defaultTime: 'current'
      
      
    
  index: ->
    
    
