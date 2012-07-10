window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  dispatcher: _.clone(Backbone.Events)

  


  log: (msg, obj=null)->
    console.log '***** ' + msg + ' *'
    if obj != null
      console.log obj
    console.log '*******************'
    
  init: (data)->
    this.events = new Tix.Collections.Events(data.events)
    this.router = new Tix.Routers.MainRouter(this.events)
    
    Backbone.history.start()
  
  config: 
    PusherAPIKey: '52fcd783b4f4c6cbf542'
    
  Pusher: new Pusher('52fcd783b4f4c6cbf542')
    
    
$(document).ready ->
  # App is initialized via bootstrapped 