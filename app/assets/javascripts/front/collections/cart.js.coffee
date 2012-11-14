class Tix.Collections.Cart extends Backbone.Collection
  model: Tix.Models.Seat
  # urlRoot: '/orders' not
  
  initialize: ->
    _.bindAll this, 'total'
    self = this
    
    self.on 'remove', @removeSeat
     
  removeSeat: (seat)->
    
    console.log ['Pre Remove Seat', Tix.Cart]
    Tix.Cart.remove(seat)
    console.log ['Post Remove Seat', Tix.Cart]
    console.log seat
    
    $.ajax
      type: 'POST'
      url: '/orders/remove_from_cart/' + seat.get('area').id
      dataType: 'json'

      success: (data)->
        console.log('removeSeat ajax Success' + data)
        

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
        
    console.log 'Add Seat'
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
    return Tix.utils.formatCurrency( @_sum('base') + @_sum('service') + @_sum('tax'), 0)
    
  _sum: (propName)->
    return _.reduce @models, (memo, seat)->
      if seat.get(propName)
        return memo + parseFloat(seat.get(propName))
      else
        return memo
    , 0
    
  _sumFormatted: (propName)->
    return Tix.utils.formatCurrency(@_sum(propName), 0)