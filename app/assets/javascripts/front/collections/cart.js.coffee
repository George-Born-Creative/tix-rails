class Tix.Collections.Cart extends Backbone.Collection
  model: Tix.Models.Seat
  # urlRoot: '/orders' not
  
  initialize: ->
    _.bindAll this, 'total'
    
    
    self = this
    
    # @serviceChargeOverrideAmount
    
    self.on 'remove', @removeSeat     
  
  serviceChargeOverride: (amnt)->
    # console.log ['serviceChargeOverride(val) called', amnt ]
    
    _.each @models, (seat)->
      
      # Remember original service charge before adjusting
      if typeof seat.get('orig_service') == 'undefined'
        seat.set('orig_service', seat.get('service') )
      
      if amnt == false # remove override if it exists
        seat.set('service', seat.get('orig_service') )
      else
        seat.set('service', parseFloat( amnt ))
        
        
      
  removeSeat: (seat)->
    
    # console.log ['Pre Remove Seat', Tix.Cart]
    Tix.Cart.remove(seat)
    # console.log ['Post Remove Seat', Tix.Cart]
    # console.log seat
    
    $.ajax
      type: 'POST'
      url: '/orders/remove_from_cart/' + seat.get('area').id
      dataType: 'json'

      success: (data)->
        # console.log('removeSeat ajax Success' + data)
        

  addSeat: (data)->
    # console.log "Cart.addSeat called"
    self = this
 
    seat = new Tix.Models.Seat
      section: data.section
      area: data.area
      event_name: data.event.name
      event_starts_at:  data.event.starts_at
      base: data.section.current_price.base
      service: data.section.current_price.service
      tax: data.section.current_price.tax
    
    $.ajax
      type: 'POST'
      url: seat.url()
      dataType: 'json'
      success: (data)->
        self.push(seat)
        # console.log data
      error: (data)->
        alert 'Oh no! Someone beat you to the punch and just nabbed this seat.\n\n Please choose another seat or try again in 10 minutes. That\'s when this seat will be released if the other party does not complete her purchase. \n\n --Jammin Java Ticketing\n     (tickets@jamminjava.com)'
        # console.log 'error'
        # console.log data

        
  subtotal: -> @_sumFormatted('base')
  service_total: ->  @_sumFormatted('service')
  tax_total: -> @_sumFormatted('tax')
  
  total: ->
    return Tix.utils.formatCurrency( @_sum('base') + @_sum('service') + @_sum('tax'), 2)
    
  _sum: (propName)->
    return _.reduce @models, (memo, seat)->
      if seat.get(propName)
        return memo + parseFloat(seat.get(propName))
      else
        return memo
    , 0
    
  _sumFormatted: (propName)->
    return Tix.utils.formatCurrency(@_sum(propName), 2)