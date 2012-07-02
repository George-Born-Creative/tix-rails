class Tix.Views.MidView extends Backbone.View
  el: $('#mid')
  
  events: {
    'click .button': 'showBody'
  }
  
  showBody: ->
    Tix.router.navigate '/buy/123', {trigger: true}
    
  initialize: ()->
