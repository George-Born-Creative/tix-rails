class Tix.Views.CheckoutFormView extends Backbone.View
  el: $('.checkout-form')
  
  events: 
    'keyup input[type="text"]' : 'inputKeyup'
    'keyup input[type="email"]' : 'inputKeyup'
    
    'change #order_service_charge_override': 'serviceChargeOverride'
  initialize: ->
    
    _.bindAll(this)

    console.log 'Tix.Views.CheckoutFormView initialized'
    
  inputKeyup: (e)->
    $input = $(e.currentTarget)
    
    if $input.val().length > 0
      $input.parent().find('label').css('display', 'none')
    else
      $input.parent().find('label').css('display', 'block')
      
  
  $('.checkout-form input')
    
  render: ->
  
  serviceChargeOverride: (e)->
    console.log 'serviceChargeOverride'
    $select = $(e.currentTarget)
    val = $select.val()
    if val != ''
      Tix.Cart.serviceChargeOverride( parseFloat( val ) )
    else
      Tix.Cart.serviceChargeOverride(false)
      # enable and set service charge override on cart