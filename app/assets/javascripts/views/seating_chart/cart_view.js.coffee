class Tix.Views.CartView extends Backbone.View
  el: '#seat_chooser'

  initialize: ->
    
    @counter = 0    
    @total = 0.00
              
    _.bindAll this, 'render', 'addItem', 'updateTotal'
        
    this.collection.bind 'add', this.addItem, this
    this.collection.bind 'add', this.updateTotal, this
    
    @$el.html("<ul class='stacked_list'></ul>")
      
    @render
    
  render: ->
    
    
  addItem:(add)-> 
    model = Tix.cart.last()
    
    @total += parseFloat model.get('price')
    
    view = new Tix.Views.SeatSelectionView({ model: model })
    this.$el.find('ul').prepend view.render()
    
  updateTotal: ->
    #@$el.find('.total').html('Total $' + @formatCurrency(@total))
    
  formatCurrency: (num)->
    num = (if isNaN(num) or num is "" or num is null then 0.00 else num)
    num = parseFloat(num).toFixed 2
    return num
    
  #respondToSeatClick: ->
  #  self = this
  #  
  #  Tix.dispatcher.on 'seat:click', (args)->
  #    console.log args
  #    self.addToSeatList(args)
  #  @render
    
    

  
  
    