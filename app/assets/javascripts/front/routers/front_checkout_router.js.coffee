class Tix.Routers.FrontCheckoutRouter extends Support.SwappingRouter
  
  routes: 
    '': 'index'
    
  initialize: (data)->
    # console.log 'Tix.Routers.FrontCheckoutRouter'
    
    view = new Tix.Views.CheckoutFormView() # operates on .checkout-form
    view.render()
  
    