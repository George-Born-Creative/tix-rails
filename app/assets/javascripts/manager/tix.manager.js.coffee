window.TixMgr =
  
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  ExternalEvents: {}
    
  Dispatcher: _.clone(Backbone.Events)
  
  
  init: ->
    # http://railscasts.com/episodes/340-datatables?view=asciicast
    TixLib.init()
    @initNav()
    @initDatatables()
    @initColorPicker()
    @initSVGHover()
    @initToggler()
    _.templateSettings = 
      interpolate : /\{\{(.+?)\}\}/g
      
    @initReportingEventSearch()
    @initCheckinSearch()
  
  startChartRouter: (data)->
    chart = new Backbone.NestedModel(data.chart)
    new TixMgr.Routers.ChartRouter({ chart: chart })
    Backbone.history.start()
    
  startEventEditRouter: (data)->
    new TixMgr.Routers.EventEditRouter()
    Backbone.history.start()
    
  initDatatables: ->
    if $('table#artists').size() > 0
      $('table#artists').dataTable({
          sPaginationType: "full_numbers"
          bJQueryUI: true
          bProcessing: true
          bServerSide: true
          sAjaxSource: $('#artists').data('source')
          'aoColumnDefs': [
            { "bSortable": false, "aTargets": [ 0, 2, 3, 4, 5] } # these corespond to the artist table columns
          ]
        
      }).addClass('display')
    
    if $('table#events').size() > 0
      $('table#events').dataTable({
          sPaginationType: "full_numbers"
          bJQueryUI: true
          bProcessing: true
          bServerSide: true
          sAjaxSource: $('#events').data('source')
          "aaSorting": [[ 2, "asc" ]]
          'aoColumnDefs': [
            { "bSortable": false, "aTargets": [ 3, 4, 5, 6] } # these corespond to the events table columns
          ]
        
      }).addClass('display')
    
    if $('table#customers').size() > 0
      $('table#customers').dataTable({
          sPaginationType: "full_numbers"
          bJQueryUI: true
          bProcessing: true
          bServerSide: true
          sAjaxSource: $('#customers').data('source')
          'aoColumnDefs': [
            { "bSortable": false, "aTargets": [ 3 ] } # these corespond to the events table columns
          ]
        
      }).addClass('display')
    
    
    
  initArtistsDelete: ->
  
  initColorPicker: ->
    if $('.chart-section-colorpicker').size() > 0
      $('.chart-section-colorpicker').colorpicker()
  
  initSVGHover: ->
    $('g#hot circle').hide()
      
    
  initNav: ->
    activeurl = window.location.pathname
    $('a[href="'+activeurl+'"]').parent('li').addClass('active')
    
  initToggler: ->
    $('a[data-action="toggle-visibility"]').click ->
      console.log 'toggle visibility clicked'
      
      on_selector = $(this).data('on_selector')
      off_selector = $(this).data('off_selector')
      
      $(on_selector).show()
      $(off_selector).hide()
    
  initReportingEventSearch: ->
    $nav = $('.events-list-nav')
    $search = $('input#event_menu_search')
    if $nav.length
      $search.liveSearch('.events-list-nav', '.event', 'a')
      
      $search.on 'keyup', ->
        if $(this).val().length > 0
          $nav.show()
        else
          $nav.hide()
      
      
      
  initCheckinSearch: ->
    if $('table#checkin tbody').length
      $('input#checkin_search').liveSearch('table#checkin tbody', 'tr', '.last_name')



Number::formatMoney = (c, d, t) ->
  n = this
  c = (if isNaN(c = Math.abs(c)) then 2 else c)
  d = (if d is `undefined` then "." else d)
  t = (if t is `undefined` then "," else t)
  s = (if n < 0 then "-" else "")
  i = parseInt(n = Math.abs(+n or 0).toFixed(c)) + ""
  j = (if (j = i.length) > 3 then j % 3 else 0)
  r = s + ((if j then i.substr(0, j) + t else "")) + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + ((if c then d + Math.abs(n - i).toFixed(c).slice(2) else ""))
  return '$' + r