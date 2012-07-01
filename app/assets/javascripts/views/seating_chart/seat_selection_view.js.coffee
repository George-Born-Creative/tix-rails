class Tix.Views.SeatSelectionView extends Backbone.View
  tagName: 'li'
  
  events: ->
    'click .close': 'removeItem'
    
    
  initialize: ->
    this.model.bind 'change', this.render, this
    
  render: ->
    label = this.model.get('label')
    price = this.model.get('price')
    
    
    $(this.el).html( this.template( {price: @formatCurrency(price), label: label }) )
    return this.el
    
    _.bindAll this, 'template'
  
  removeItem: (e)->
    console.log Tix.cart.length
    Tix.cart.remove this.model
    self = this
    @$el.slideUp 'fast', ->
      self.remove()
    e.preventDefault()
    return false
  
  template: (args)->
    _.template "<%= label %><span class='default_price'>$<%= price %></span><a href='#' class='close'>x</a>", args
  
  
  
  formatCurrency: (num)->
    num = (if isNaN(num) or num is "" or num is null then 0.00 else num)
    num = parseFloat(num).toFixed 2
    return num