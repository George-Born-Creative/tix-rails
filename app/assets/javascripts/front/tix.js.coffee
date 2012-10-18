window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  ExternalEvents: {}
  Dispatcher: _.clone(Backbone.Events)
  

  log: (msg, obj)->
    return; # stub function is default

  initTixLogger: ->
    Tix.log = (msg, obj=null)->
      console.log 'Tix : ' + msg
      if obj != null
        console.log obj
            
  utils: 
    formatCurrency: (price)->
      return '$' + parseFloat(price).toFixed(2).toString()
    
  init: (data)-> # maps input data

    this.router = new Tix.Routers.MainRouter(data.events)
  
    Tix.pusherAPIKey = data.pusherAPIKey
    
    Tix.ExternalEvents.init()
    Tix.OrderProcessor.init()
    Tix.Editables.init()
    
    
    
    if data.env == 'development'
      
      Tix.initLoggers()
      
    Backbone.history.start()
    
  initLoggers: ->
    Tix.ExternalEvents.initPusherLog()
    Tix.initTixLogger()
    
