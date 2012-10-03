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
       defaultTime: 'value'
    
    @initArtistTokenInput()
    
  
  index: ->
    
  initArtistTokenInput: ()->
    $('.artist-token-input').each (i, input)->
      $i = $(input)
      
      limit = if $i.hasClass('single') then 1 else null
      console.log limit
      
      $i.tokenInput '/manager/artists/search.json',
        prePopulate:       $("#image_tag_list").data("pre")
        preventDuplicates: true
        noResultsText:     "No results, needs to be created."
        animateDropdown:   false
        theme: 'facebook'
        tokenLimit: limit
    
    
    
    
