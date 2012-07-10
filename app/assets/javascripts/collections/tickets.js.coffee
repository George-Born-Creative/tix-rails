class Tix.Collections.Tickets extends Backbone.Collection
  model: Tix.Models.Ticket
  

  
  filterByAreaId: (area_id)->
    area_id = area_id
    return  _.filter this.models, (item)->
      a = item.get 'area_id'
      b = area_id
      is_open = ( item.get 'state' ) == 'open'
      return ( a == b ) && is_open
      