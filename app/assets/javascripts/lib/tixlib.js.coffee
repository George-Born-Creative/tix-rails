window.TixLib =
  
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  ExternalEvents: {}
    
  Dispatcher: _.clone(Backbone.Events)
  
  
  openExternalLinksInNewWindow: ->
    # http://css-tricks.com/snippets/jquery/open-external-links-in-new-window/
    $("a[href^='http://']").each ->
      a = new RegExp("/" + window.location.host + "/")
      unless a.test(@href)
        $(this).click (event) ->
          event.preventDefault()
          event.stopPropagation()
          window.open @href, "_blank"

    
  setupAjax: ->
    $.ajaxSetup
      beforeSend: (xhr)->
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      

  dontJumpOnBlankAnchors: ->
    $('a[href="#"]').click (e)->
      e.preventDefault()
    
    
  # getCSRFToken: ->
  #   $.getJSON '/tokens.json', (response)->
  #     $("meta[name='csrf-token']").attr('content', response.token)
  #     $("meta[name='csrf-param']").attr('content', response.param)
  #     TixLib.Dispatcher.trigger('CSRFAvailable')
 
      
  
  init: ->
    # http://railscasts.com/episodes/340-datatables?view=asciicast

    @openExternalLinksInNewWindow()
    @dontJumpOnBlankAnchors()
    @setupAjax()
    # @getCSRFToken()