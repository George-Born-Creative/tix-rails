class Tix.Routers.FrontCheckoutRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
    'register': 'register'
  
    
  initialize: (data)->
    console.log 'Initialized Tix.Routers.FrontCheckoutRouter'
    @setupLoginOrRegister()
    @setupSignInForm()
    Backbone.history.start()

  
  index: ->

    
  register: ->
    console.log "FIRE /register"
    $('div.sign-in').hide()
    $('div.register').fadeIn('fast')
    
    
  setupLoginOrRegister: ->
    $('input[name="new_customer"]').change ->
      val = $(this).val()
      $pass = $('div.sign-in input[name="user[password]"]')
      
      if val == 'yes' # user is a customer, so enable password
        $pass.removeAttr('disabled')
      else   # user is not a customer, so show registration form
        $pass.attr('disabled', 'disabled')
        
  
  setupSignInForm: ->
    self = this
    $('form#user_sign_in').submit (e)->
      $i = $('input[name="new_customer"]:checked')
      val = $i.val()
      # console.log ['val', val]
      if val == 'no'
        self.navigate('register', {trigger: true})#()
        e.preventDefault()
        return false
        
  
  