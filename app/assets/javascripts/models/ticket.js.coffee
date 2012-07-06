class Tix.Models.Ticket extends Backbone.Model  
  
  initialize: ->        
    #_.bindAll this,
  
  
  setFormattedPrice: ->
    num = this.price
    
    num = (if isNaN(num) or num is "" or num is null then 0.00 else num)
    num = parseFloat(num).toFixed 2
    
    this.formattedPrice = num