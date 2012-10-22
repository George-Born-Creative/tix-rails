class Tix.Collections.Cart extends Backbone.Collection
  model: Tix.Models.Seat
  # urlRoot: '/orders' not
  
  initialize: ->
    _.bindAll this, 'total'
      
  addSeat: (data)->
    # console.log "Cart.addSeat called"
    
 
    
    seat = new Tix.Models.Seat
      section: data.section
      area: data.area
      event_name: data.event.name
      event_starts_at:  data.event.starts_at
      base: data.section.current_price.base
      service: data.section.current_price.service
      tax: data.section.current_price.tax
        
    console.log seat
    console.log seat.url()
    
    
    @push(seat)
    
    $.ajax
      type: 'POST'
      url: seat.url()

      success: (data)->
        alert('Success' + data)

         
    
    
    
  subtotal: -> @_sumFormatted('base')
  service_total: -> @_sumFormatted('service')
  tax_total: -> @_sumFormatted('tax')
  
  total: ->
    return Tix.utils.formatCurrency( @_sum('base') + @_sum('service') + @_sum('tax'))
    
  _sum: (propName)->
    return _.reduce @models, (memo, seat)->
      return memo + parseFloat(seat.get(propName))
    , 0
    
  _sumFormatted: (propName)->
    return Tix.utils.formatCurrency(@_sum(propName))