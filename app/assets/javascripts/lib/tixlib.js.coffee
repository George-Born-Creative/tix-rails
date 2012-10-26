window.TixLib =
  
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  ExternalEvents: {}
    
  Dispatcher: _.clone(Backbone.Events)
  
  init: ->
    # http://railscasts.com/episodes/340-datatables?view=asciicast
    
    console.log '$.ajaxSetup'
    
    $.ajaxSetup
      beforeSend: (xhr)->
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      