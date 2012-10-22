class Tix.Collections.Cart extends Backbone.Collection
  model: Tix.Models.Seat
  # urlRoot: '/orders'
  
  cart_total: ->
    _.each @models, (ticket)->
      console.log ['ticket', ticket, ticket.get('total')]
      #t=parseFloat(ticket.attributes.total)
      #console.log(t)
      # return memo + t
      
  addSeat: (data)->
    console.log "Cart.addSeat called"

    seat = new Tix.Models.Seat
      section: data.section
      area: data.area
      event_name: data.event.name
      event_starts_at:  data.event.starts_at
      base: data.section.current_price.base
      service: data.section.current_price.service
      tax: data.section.current_price.tax
        
    console.log seat
    
    @push(seat)
    
    
    
  subtotal: -> @_sumFormatted('base')
  service_total: -> @_sumFormatted('service')
  tax_total: -> @_sumFormatted('tax')
  
  total: ->
    Tix.utils.formatCurrency( @_sum('base') + @_sum('subtotal') + @_sum('tax'))
    
  _sum: (propName)->
    return _.reduce @models, (memo, seat)->
      return memo + parseFloat(seat.get(propName))
    , 0
    
  _sumFormatted: (propName)->
    return Tix.utils.formatCurrency(@_sum(propName))