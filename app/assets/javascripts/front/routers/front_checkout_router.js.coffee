class Tix.Routers.FrontCheckoutRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
    'register': 'register'
    
  initialize: (data)->
    # console.log 'Tix.Routers.FrontCheckoutRouter'
    
    view = new Tix.Views.CheckoutFormView() # operates on .checkout-form
    view.render()
    
    @initSignIn()
    
  initSignIn: ->
    self = this
    $('form#user_sign_in').submit (e)->      
      $i = $('input[name="new_customer"]:checked')
      val = $i.val()
      # console.log ['val', val]
      if val == 'no'
        self.register()
        # self.navigate('register', {trigger: true}) #()
        e.preventDefault()
        return false


  register: ->
    # console.log "FIRE /register"
    $('div.sign-in').hide()
    $('div.register').fadeIn('fast')