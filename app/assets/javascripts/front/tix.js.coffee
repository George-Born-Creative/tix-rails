if typeof console is "undefined"
  window.console = log: -> {} 

window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  # Dispatcher: _.clone(Backbone.Events)
  
  utils: 
    formatCurrency: (price)->
      return '$' + parseFloat(price).toFixed(2).toString()
    
  init: (data)->
    self = this

    TixLib.init()
    
    
    
    $.ajax 
      url: '/users/user_env'
      type: 'post'
      dataType: 'json'
      success: (data)->
        console.log data
        self.initCart()
        self.initCartMiniView()
        self.initCartView(data)
        self.initChart()
        self.initLogin()
        if data.role == 'employee' || data.role == 'owner' || data.role == 'manager'
          self.initEditButtons()
  
  initEditButtons: ->
    $('.admin-button').fadeIn()
    
    
  initLogin: ->
    $.ajax 
      url: '/users/login_env'
      type: 'post'
      dataType: 'json'
      success: (data)->
        $('.login').hide().append(data.html).fadeIn('fast')
  
    
  initCart: ->
    Tix.Cart = new Tix.Collections.Cart()
    
  initCartMiniView: ->
    cartMiniView = new Tix.Views.CartMiniView()
    Tix.Cart.on 'add', -> cartMiniView.render()
    Tix.Cart.on 'remove', -> cartMiniView.render()
    
  initCartView: (data)->
    self = @
    # When cart changes, add item
    order = data.order
    if order
      console.log ["ORDER EXISTS", data.order] 
      _.each data.order.tickets, (ticket)->
        console.log ['ticket', ticket]
        seat = new Tix.Models.Seat
          ticket_id: ticket.id
          event_name:  ticket.event_name
          section:
            label: ticket.section_label
          area:
            label:  ticket.area_label
            id: ticket.area_id
          base: ticket.base_price
          service: ticket.service_charge
          
        Tix.Cart.add(seat)
        self.renderCartItem(seat)
        
        
        
        # @renderCartItem(seat)
        
        # event_name
        # section.label
        # area.label
        # base

        
        
          
          
          
    Tix.Cart.on 'add', (seat)->
      @renderCartItem(seat)
    , this
      
  renderCartItem: (seat)->
    view = new Tix.Views.CartItemSmall({model: seat})
    $('#cart_container').prepend(view.render().el)
    
    
  initChart: ->
    if Tix.Chart
      new Tix.Routers.FrontChartRouter({chart:Tix.Chart})
      
      
      
      
    