class Tix.Views.CheckoutView extends Backbone.View
  el: '#checkout'
  
  
  initialize: ->
    this.collection.bind 'add', @updateTotal, this
    this.collection.bind 'remove', @updateTotal, this
    
  updateTotal: ->
    total = this.collection.total()
    @$el.find('.total').html('$'+total)
  
  