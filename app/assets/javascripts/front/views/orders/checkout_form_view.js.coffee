class Tix.Views.CheckoutFormView extends Backbone.View
  el: $('.checkout-form')
  
  events: 
    'keyup input[type="text"]' : 'inputKeyup'
    'keyup input[type="email"]' : 'inputKeyup'

    'change #order_service_charge_override': 'serviceChargeOverride'
    
  initialize: ->
    
    @initLabels()

    @initSelects()
    
    _.bindAll(this)

    # console.log 'Tix.Views.CheckoutFormView initialized'
    
    # setInterval @initLabels, 2000 # need repeated checks to catch autocomplete
  
    $('form.edit_order').on('submit', @formSubmit)
    
  formSubmit: (e)->
    # console.log 'formSubmit'
    $('input[type="submit"]')
      .attr('disabled', 'disabled')
      .css('backgroud', '#333')
      .val('Processing...')
    
    # TODO add validations
  
  initSelects: ->

            
              
            
        
      
    
      
  initLabels: ->
    self = this
    @$el.find('input[type="text"], input[type="email"]').each (i, input)->
      self.setLabelVisibility( $( input ) )
    
  inputKeyup: (e)->
    $input = $(e.currentTarget)
    @setLabelVisibility($input)
      
    
  setLabelVisibility: ($input) ->
    new_val = if $input.val().length > 0  then 'none' else 'block'
    
    $label = $input.parent().find('label')
      
    new_val = if $input.val().length > 0  then 'none' else 'block'
    $label.css('display', new_val)
    
  
  $('.checkout-form input')
    
  render: ->
  
  serviceChargeOverride: (e)->
    # console.log 'Tix.Views.CheckoutFormView#serviceChargeOverride()'
    $select = $(e.currentTarget)
    val = $select.val()
    if val != ''
      Tix.Cart.serviceChargeOverride( parseFloat( val ) )
    else
      Tix.Cart.serviceChargeOverride(false)
      # enable and set service charge override on cart