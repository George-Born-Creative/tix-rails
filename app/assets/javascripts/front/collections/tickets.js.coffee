class Tix.Collections.Tickets extends Backbone.Collection
  model: Tix.Models.Ticket
  
  
  initialize: ->  
    _.bindAll this, 'activeAreaIds'
  
  activeAreaIds: ->
    aa = []
    _.each @models, (ticket)->
      if 'open' == ticket.get('status')
        aa.push( ticket.get('area_id') )
    return _.flatten aa
      
    
  filterByAreaId: (area_id)->
    return  _.filter this.models, (item)->
      a = parseInt item.get 'area_id'
      b = parseInt area_id
      is_open = ( item.get 'status' ) == 'open'

      return ( a == b ) && is_open
      
      
      