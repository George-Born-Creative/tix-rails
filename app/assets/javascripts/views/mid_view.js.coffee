class Tix.Views.MidView extends Backbone.View
  el: $('#mid')
  
  events: {
    'click .button': 'showBody'
  }
  
  showBody: ->
    $('#body').slideToggle()
    
  initialize: ()->
