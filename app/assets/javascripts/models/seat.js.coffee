class Tix.Models.Seat extends Backbone.Model
  # States: unavailable, available, in_cart
  
  defaults: {
    state: 'available'
  }
  
  initialize: ->        
    _.bindAll this, 'setFormattedPrice'
  
  
  setFormattedPrice: ->
    num = this.price
    
    num = (if isNaN(num) or num is "" or num is null then 0.00 else num)
    num = parseFloat(num).toFixed 2
    
    this.formattedPrice = num