if typeof console is "undefined"
  window.console = log: -> {} 

window.Tix =
  Models: {}
  Collections: {} 
  Views: {}
  Routers: {}
  # Dispatcher: _.clone(Backbone.Events)
  
  utils: 
    formatCurrency: (price, digits=2)->
      return '$' + parseFloat(price).toFixed(digits).toString()
    
  init: (data)->
    self = this

    TixLib.init()
    
    
    
    $.ajax 
      url: '/users/user_env'
      type: 'post'
      dataType: 'json'
      success: (data)->
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
    
  initTimer: (data)->
    self = this
    seconds_til_expiration = data.order.expires_in_seconds
    
    # console.log ['initTimer(data)', seconds_til_expiration]
    @timer = new TixLib.Timer()
    @timer.init(seconds_til_expiration)
    
    TixLib.Dispatcher.on 'tick', (data)->
      $('.countdown .time').text(data.time)
      
    Tix.Cart.on 'add', ->
      self.timer.init(600) # 10 minutes
    
    
  initCartView: (data)->
    self = @
    
    # When cart changes, add item
    order = data.order
    if order
      console.log ["ORDER EXISTS!", data.order] 
      
      _.each data.order.tickets, (ticket)->

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
          
    Tix.Cart.on 'add', (seat)->
      @renderCartItem(seat)
    , this
    
    @initTimer(data)
    
      
  renderCartItem: (seat)->
    view = new Tix.Views.CartItemSmall({model: seat})
    $el = $(view.render().el)
    $el.prependTo('#cart_container').hide().fadeIn('fast')
    
    
  initChart: ->
    if Tix.Chart
      new Tix.Routers.FrontChartRouter({chart:Tix.Chart})
      
      
      
      
    