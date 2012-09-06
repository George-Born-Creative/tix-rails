window.TixMgr = {
  
  Dispatcher: _.clone(Backbone.Events)
  
  
  init: ->
    # http://railscasts.com/episodes/340-datatables?view=asciicast
    @initNav()
    @initDatatables()
    @initColorPicker()
    @initSVGHover()
    
  
  
  initDatatables: ->
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
    
    
    $('table#events').dataTable({
        sPaginationType: "full_numbers"
        bJQueryUI: true
        bProcessing: true
        bServerSide: true
        sAjaxSource: $('#events').data('source')
        'aoColumnDefs': [
          { "bSortable": false, "aTargets": [ 2, 3, 4, 5] } # these corespond to the events table columns
        ]
        
    }).addClass('display')
    
    
    $('table#customers').dataTable({
        sPaginationType: "full_numbers"
        bJQueryUI: true
        bProcessing: true
        bServerSide: true
        sAjaxSource: $('#customers').data('source')
        'aoColumnDefs': [
          { "bSortable": false, "aTargets": [ 2, 3, 4, 5] } # these corespond to the events table columns
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
}